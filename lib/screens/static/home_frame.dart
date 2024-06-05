import 'package:analysisrobo/core/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:convert';

import '../../bloc/client/client_cubit.dart';
import '../../services/api.dart';

class HomeScreenFrame extends StatefulWidget {
  const HomeScreenFrame({super.key});

  @override
  State<HomeScreenFrame> createState() => _HomeScreenFrameState();
}

class _HomeScreenFrameState extends State<HomeScreenFrame> {
  pageConfig() async {
    Api api = Api();
    final server = await api.splash();
  }

  List<CoinPrice> _lineChartData = [];
  bool _loading = false;
  final TextEditingController _controller = TextEditingController();

  Future<void> _fetchCoinData(String coin) async {
    setState(() {
      _loading = true;
    });

    final response = await http.get(
        Uri.parse('https://api.binance.com/api/v3/klines?symbol=${coin}USDT&interval=1d&limit=30'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<CoinPrice> prices = data.map<CoinPrice>((item) {
        DateTime date = DateTime.fromMillisecondsSinceEpoch(item[0], isUtc: true);
        return CoinPrice(date: date, price: double.parse(item[4]));
      }).toList();

      setState(() {
        _lineChartData = prices;
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
      throw Exception('Failed to load coin data');
    }
  }

  late ClientCubit clientCubit;
  @override
  void initState() {
    super.initState();
    clientCubit = context.read<ClientCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).getTranslate("symbol"),
                ),
                onSubmitted: (String value) {
                  _fetchCoinData(value.toUpperCase());
                },
              ),
              const Gap(20),
              Expanded(
                child: _loading
                    ? const Center(child: CircularProgressIndicator())
                    : _lineChartData.isEmpty
                        ? Center(
                            child: Text(AppLocalizations.of(context).getTranslate("symbol_text")))
                        : SfCartesianChart(
                            primaryXAxis: DateTimeAxis(
                              dateFormat: DateFormat.Md(),
                              intervalType: DateTimeIntervalType.days,
                              interval: 5, // Show date every 5 days
                            ),
                            primaryYAxis: const NumericAxis(
                              interval: 500, // Adjust the interval for price labels
                            ),
                            series: <CartesianSeries>[
                              LineSeries<CoinPrice, DateTime>(
                                dataSource: _lineChartData,
                                xValueMapper: (CoinPrice price, _) => price.date,
                                yValueMapper: (CoinPrice price, _) => price.price,
                                dataLabelSettings: const DataLabelSettings(isVisible: false),
                                color: Colors.blue,
                                width: 2,
                              ),
                            ],
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CoinPrice {
  final DateTime date;
  final double price;

  CoinPrice({required this.date, required this.price});
}
