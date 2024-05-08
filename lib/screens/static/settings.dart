import 'package:analysisrobo/bloc/client/client_cubit.dart';
import 'package:analysisrobo/widgets/downmenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/settingsitem.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late ClientCubit clientCubit;

  @override
  void initState() {
    super.initState();
    clientCubit = context.read<ClientCubit>();
  }

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
                    onTap: () => GoRouter.of(context).push("/profile"),
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 120,
                    endIndent: 120,
                  ),
                  SettingsItem(
                    icon: CupertinoIcons.bell,
                    title: "Notifications",
                    onTap: () => GoRouter.of(context).push("/notification"),
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 120,
                    endIndent: 120,
                  ),
                  SettingsItem(
                    icon: CupertinoIcons.eye,
                    title: "Appearance",
                    onTap: () => GoRouter.of(context).push("/theme"),
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 120,
                    endIndent: 120,
                  ),
                  SettingsItem(
                    icon: Icons.headphones_outlined,
                    title: "Help/Support",
                    onTap: () => GoRouter.of(context).push("/"),
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 120,
                    endIndent: 120,
                  ),
                  SettingsItem(
                    icon: CupertinoIcons.question_circle,
                    title: "About",
                    onTap: () => GoRouter.of(context).push("/about"),
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 120,
                    endIndent: 120,
                  ),
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
