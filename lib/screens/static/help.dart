// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
// import 'dart:math';
import 'package:InvenstAnalys/bloc/client/client_cubit.dart';
import 'package:InvenstAnalys/core/localizations.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  bool loading = true;
  List<dynamic> helpData = [];
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  List<Map<String, dynamic>> responses = [];

  @override
  void initState() {
    super.initState();
    loadData();
    clientCubit = context.read<ClientCubit>();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    final data = await rootBundle.loadString('assets/bot/helper.json');
    setState(() {
      helpData = jsonDecode(data);
      loading = false;
    });
  }

  void query() {
    Set<Map<String, dynamic>> responsesX = {};

    responsesX.add({
      "msg": searchController.text,
      "me": true,
    });

    var searchWords = searchController.text.split(' ');

    for (var element in helpData) {
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
    searchController.clear();

    setState(() {
      responses.addAll(responsesX);
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  late ClientCubit clientCubit;

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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: responses.length,
                      itemBuilder: (context, index) => BubbleSpecialThree(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        text: responses[index]["msg"],
                        textStyle: TextStyle(color: Theme.of(context).colorScheme.inverseSurface),
                        tail: true,
                        isSender: responses[index]["me"],
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: TextField(
                        controller: searchController,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: query,
                    icon: Icon(Icons.send),
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
