import 'package:analysisrobo/bloc/client/client_cubit.dart';
import 'package:analysisrobo/core/localizations.dart';
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
    return BlocBuilder<ClientCubit, ClientState>(builder: (context, state) {
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
                      title: AppLocalizations.of(context).getTranslate("account"),
                      onTap: () => GoRouter.of(context).push("/profile"),
                    ),
                    const Divider(
                      thickness: 1,
                      indent: 90,
                      endIndent: 90,
                    ),
                    SettingsItem(
                      icon: CupertinoIcons.bell,
                      title: AppLocalizations.of(context).getTranslate("notifications"),
                      onTap: () => GoRouter.of(context).push("/notification"),
                    ),
                    const Divider(
                      thickness: 1,
                      indent: 90,
                      endIndent: 90,
                    ),
                    SettingsItem(
                      icon: CupertinoIcons.eye,
                      title: AppLocalizations.of(context).getTranslate("appearance"),
                      onTap: () => GoRouter.of(context).push("/theme"),
                    ),
                    const Divider(
                      thickness: 1,
                      indent: 90,
                      endIndent: 90,
                    ),
                    SettingsItem(
                      icon: Icons.language_outlined,
                      title: AppLocalizations.of(context).getTranslate("language"),
                      onTap: () => GoRouter.of(context).push("/language"),
                    ),
                    const Divider(
                      thickness: 1,
                      indent: 90,
                      endIndent: 90,
                    ),
                    SettingsItem(
                      icon: Icons.headphones_outlined,
                      title: AppLocalizations.of(context).getTranslate("help"),
                      onTap: () => GoRouter.of(context).push("/help"),
                    ),
                    const Divider(
                      thickness: 1,
                      indent: 90,
                      endIndent: 90,
                    ),
                    SettingsItem(
                      icon: CupertinoIcons.question_circle,
                      title: AppLocalizations.of(context).getTranslate("about"),
                      onTap: () => GoRouter.of(context).push("/about"),
                    ),
                    const Divider(
                      thickness: 1,
                      indent: 90,
                      endIndent: 90,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
