// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:preload_page_view/preload_page_view.dart';
import '../../core/storage.dart';
import '../../widgets/boardingitem.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  // Boarding Screen image, title and description
  final boardingData = [
    {
      "image": "assets/images/boarding-1.webp",
      "title": "Choose Product.",
      "description": "We have a 1k+ Product. Choose Your product from our E-commerce shop.",
    },
    {
      "image": "assets/images/boarding-1.webp",
      "title": "Buy Product.",
      "description": "Easily purchase your chosen products with our seamless checkout process.",
    },
  ];

  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PreloadPageView.builder(
          itemCount: boardingData.length,
          preloadPagesCount: boardingData.length,
          onPageChanged: (value) {
            setState(() {
              page = value;
            });
          },
          itemBuilder: (context, index) => BoardingItem(
            // BoardingItem
            image: boardingData[index]["image"]!,
            title: boardingData[index]["title"]!,
            description: boardingData[index]["description"]!,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 26),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              // 3 Dot
              height: 70,
              child: Align(
                alignment: Alignment.center,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: boardingData.length,
                  itemBuilder: (context, index) => Icon(
                    page == index ? Icons.circle_outlined : Icons.circle,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: OutlinedButton(
                onPressed: () async {
                  final storage = Storage();
                  await storage.firstLauched();
                  GoRouter.of(context).replace("/home");
                },
                child: Text(page == boardingData.length - 1 ? "Finish" : "Skip"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
