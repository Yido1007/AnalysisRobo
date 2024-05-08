import 'package:analysisrobo/core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/downmenu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController symbolController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  String predictionResult = '';
  bool isLoading = false;

  Future<void> predictStock() async {
    setState(() {
      isLoading = true;
    });

    try {
      final String symbol = symbolController.text;
      final String startDate = startDateController.text;
      final String endDate = endDateController.text;

      final response = await http
          .get(Uri.parse('https://api-v2.investing.com/instruments/StocksData?pair_ID=$symbol'));

      if (response.statusCode == 200) {
        // Parse response data
        final data = json.decode(response.body);
        // Extracting necessary data
        final stockData = data['data'][0];
        final symbolName = stockData['symbol'];
        final companyName = stockData['company_name'];

        // Call your Python API endpoint to get prediction
        final predictionResponse = await http.post(
          Uri.parse('http://127.0.0.1:5000'),
          body: {
            'symbol': symbol,
            'start_date': startDate,
            'end_date': endDate,
          },
        );

        if (predictionResponse.statusCode == 200) {
          // Parse prediction response data
          final predictionData = json.decode(predictionResponse.body);
          final predictions = predictionData['predictions'];

          setState(() {
            predictionResult = 'Predictions for $symbolName ($companyName):\n\n$predictions';
            isLoading = false;
          });
        } else {
          setState(() {
            predictionResult = 'Error occurred while fetching predictions.';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          predictionResult = 'Error occurred while fetching stock data.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        predictionResult = 'An error occurred: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis Robo'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: symbolController,
                    decoration: const InputDecoration(labelText: 'Symbol (e.g., TCELL.IS)'),
                  ),
                  TextField(
                    controller: startDateController,
                    decoration: const InputDecoration(labelText: 'Start Date (YYYY-MM-DD)'),
                  ),
                  TextField(
                    controller: endDateController,
                    decoration: const InputDecoration(labelText: 'End Date (YYYY-MM-DD)'),
                  ),
                  const Gap(16),
                  ElevatedButton(
                    onPressed: predictStock,
                    child: Text(AppLocalizations.of(context).getTranslate("predict")),
                  ),
                  const Gap(16),
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              predictionResult,
                            ),
                          ),
                        ),
                ],
              ),
            ),
            const DownMenu()
          ],
        ),
      ),
    );
  }
}
