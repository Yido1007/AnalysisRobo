import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProfileItem extends StatelessWidget {
  final String text1;
  final String text2;
  const ProfileItem({
    super.key,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
      child: Row(
        children: [
          Row(
            children: [
              Text(
                text1,
                style: const TextStyle(fontSize: 22),
              ),
              const Gap(8),
              Text(
                text2,
                style: const TextStyle(fontSize: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
