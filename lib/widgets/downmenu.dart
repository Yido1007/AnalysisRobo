import 'package:analysisrobo/core/localizations.dart';
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
            title: AppLocalizations.of(context).getTranslate("home"),
            onTap: () => GoRouter.of(context).push("/home"),
          ),
          DownMenuItem(
            icon: CupertinoIcons.money_dollar,
            title: AppLocalizations.of(context).getTranslate("exchange"),
            onTap: () => GoRouter.of(context).push("/exchange"),
          ),
          DownMenuItem(
            icon: Icons.settings,
            title: AppLocalizations.of(context).getTranslate("settings"),
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
