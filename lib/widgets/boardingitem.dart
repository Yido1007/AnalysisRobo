import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BoardingItem extends StatelessWidget {
  final AssetImage image;
  final String title;
  final String description;

  const BoardingItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image(image: image),
            Column(
              children: [
                const Gap(20),
                Text(
                  title,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const Gap(20),
                Text(description),
                const Gap(20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
