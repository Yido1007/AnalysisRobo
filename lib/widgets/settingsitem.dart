// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function() onTap;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon),
                const Gap(5),
                Text(title),
              ],
            ),
            const Icon(Icons.arrow_forward)
          ],
        ),
      ),
    );
  }
}
