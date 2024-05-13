// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
// import 'dart:math';
import 'package:analysisrobo/bloc/client/client_cubit.dart';
import 'package:analysisrobo/core/localizations.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  bool loading = true;
  List<dynamic> petData = [];
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> responses = [];

  loadData() async {
    final data = await rootBundle.loadString('petbot.json');
    setState(() {
      petData = jsonDecode(data);
      loading = false;
    });
  }

  query() {
    Set<Map<String, dynamic>> responsesX = {};

    responsesX.add({
      "msg": searchController.text,
      "me": true,
    });

    var searchWords = searchController.text.split(' ');

    for (var element in petData) {
      var p = element["user_input"].cast<String>();
      var p2 = element["required_words"].cast<String>();

      int matched = 0;
      for (var t in searchWords) {
        if (p.contains(t)) {
          matched++;
        }
      }
      int matched2 = 0;
      for (var t in searchWords) {
        if (p2.contains(t)) {
          matched2++;
        }
      }

      if (matched == searchWords.length && matched2 == p2.length) {
        responsesX.add({
          "msg": element["bot_response"],
          "me": false,
        });
      }
    }
    searchController.text = "";
    setState(() {
      responses.addAll(responsesX);
    });
  }

  late ClientCubit clientCubit;
  @override
  void initState() {
    super.initState();
    loadData();
    clientCubit = context.read<ClientCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientCubit, ClientState>(builder: (context, state) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).getTranslate("help")),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: SizedBox.expand(
                  child: ListView.builder(
                    itemCount: responses.length,
                    itemBuilder: (context, index) => BubbleSpecialThree(
                      text: responses[index]["msg"],
                      tail: true,
                      isSender: responses[index]["me"],
                    ),
                  ),
                ),
              ),
              //Text field padding
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      // Text field
                      child: TextField(
                        controller: searchController,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: query,
                    icon: Icon(
                      Icons.send,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
