import 'package:flutter/cupertino.dart';
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
  final boardingData = [
    {
      "image": "",
      "title": "Buy all you need.",
      "description": "You can order what you want in just seconds using our awesome application.",
    },
    {
      "image": "",
      "title": "Second Hand Products",
      "description":
          "You can buy second hand products to save your money and pay less withing millions of sellers.",
    },
    {
      "image": "",
      "title": "Sell your used stuff",
      "description": "You can sell your used stuff to millions of users we have in just seconds.",
    }
  ];

  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () async {
                final storage = Storage();
                await storage.firstLauched();
                // ignore: use_build_context_synchronously
                GoRouter.of(context).replace("/home");
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: page == boardingData.length ? const Text("finish") : const Text("skip"),
              ),
            ),
          ),
        ],
      ),
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
              image: boardingData[index]["image"]!,
              title: boardingData[index]["title"]!,
              description: boardingData[index]["description"]!),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Align(
          alignment: Alignment.center,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: boardingData.length,
            itemBuilder: (context, index) => Icon(
              page == index ? CupertinoIcons.circle_filled : CupertinoIcons.circle,
            ),
          ),
        ),
      ),
    );
  }
}
