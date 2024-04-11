import 'package:analysisrobo/widgets/menu/downmenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/page/settingsitem.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SettingsItem(
                    icon: CupertinoIcons.person,
                    title: "Account",
                    onTap: () => "",
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 120,
                    endIndent: 120,
                  ),
                  SettingsItem(
                    icon: CupertinoIcons.bell,
                    title: "Notifications",
                    onTap: () => "",
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 120,
                    endIndent: 120,
                  ),
                  SettingsItem(
                    icon: CupertinoIcons.eye,
                    title: "Appearance",
                    onTap: () => "",
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 120,
                    endIndent: 120,
                  ),
                  SettingsItem(
                    icon: Icons.headphones_outlined,
                    title: "Help/Support",
                    onTap: () => "",
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 120,
                    endIndent: 120,
                  ),
                  SettingsItem(
                    icon: CupertinoIcons.question_circle,
                    title: "About",
                    onTap: () => "",
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 120,
                    endIndent: 120,
                  ),
                  LogoutItem(
                    icon: Icons.logout_sharp,
                    title: "Logout",
                    onTap: () => "",
                  )
                ],
              ),
            ),
            const DownMenu(),
          ],
        ),
      ),
    );
  }
}
