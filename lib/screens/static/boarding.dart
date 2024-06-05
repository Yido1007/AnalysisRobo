// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace, prefer_const_constructors, use_key_in_widget_constructors, unnecessary_string_escapes

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:preload_page_view/preload_page_view.dart';
// import '../../core/localizations.dart';
import '../../core/storage.dart';
import '../../widgets/boardingitem.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({Key? key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  int page = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PreloadPageView(
          preloadPagesCount: 3,
          onPageChanged: (value) {
            setState(() {
              page = value;
            });
          },
          children: const [
            BoardingItem(
                image: AssetImage('assets/images/boarding-1.webp'),
                title: "Title",
                description: "Description"),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(page == 0 ? CupertinoIcons.circle_filled : CupertinoIcons.circle),
                  Icon(page == 1 ? CupertinoIcons.circle_filled : CupertinoIcons.circle),
                  Icon(page == 2 ? CupertinoIcons.circle_filled : CupertinoIcons.circle),
                  Icon(page == 3 ? CupertinoIcons.circle_filled : CupertinoIcons.circle),
                  Icon(page == 4 ? CupertinoIcons.circle_filled : CupertinoIcons.circle),
                ],
              ),
              InkWell(
                onTap: () async {
                  final storage = Storage();
                  await storage.isFirstLaunch();
                  GoRouter.of(context).replace("/home");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(page == 4 ? "Finish" : "Skip"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
