import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DownMenu extends StatelessWidget {
  const DownMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DownMenuItem(
            icon: CupertinoIcons.home,
            title: "Home",
            onTap: () => GoRouter.of(context).push("/home"),
          ),
          DownMenuItem(
            icon: CupertinoIcons.money_dollar,
            title: "Exchange",
            onTap: () => GoRouter.of(context).push("/exchange"),
          ),
          DownMenuItem(
            icon: Icons.settings,
            title: "Settings",
            onTap: () => GoRouter.of(context).push("/settings"),
          ),
        ],
      ),
    );
  }
}

class DownMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function() onTap;
  const DownMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Icon(
              (icon),
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}
