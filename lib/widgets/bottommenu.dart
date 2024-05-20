import 'package:analysisrobo/core/localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        switch (value) {
          case 0:
            GoRouter.of(context).go("/home");
            break;
          case 1:
            GoRouter.of(context).go("/exchange");
            break;
          case 2:
            GoRouter.of(context).go("/settings");
            break;
        }
      },
      // Home Screen Navigation
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          label: AppLocalizations.of(context).getTranslate("home"),
        ),
        // Coins Screen Navigation
        BottomNavigationBarItem(
          icon: const Icon(CupertinoIcons.money_dollar),
          label: AppLocalizations.of(context).getTranslate("exchange"),
        ),
        // Settings Screen Navigation
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: AppLocalizations.of(context).getTranslate("settings"),
        ),
      ],
    );
  }
}
