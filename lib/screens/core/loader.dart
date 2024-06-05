// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:analysisrobo/bloc/client/client_cubit.dart';
import 'package:analysisrobo/screens/core/cache.dart';
import 'package:analysisrobo/screens/core/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/storage.dart';

class LoaderScreen extends StatefulWidget {
  const LoaderScreen({super.key});

  @override
  State<LoaderScreen> createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  Map<String, dynamic> pageConfig = {};
  bool configLoader = false;

  late ClientCubit clientCubit;
  loadApp() async {
    CacheSystem cs = CacheSystem();

    final pageConfig = await cs.splashConfig();

    setState(() {
      this.pageConfig = pageConfig;
      configLoader = true;
    });

    final storage = Storage();
    // await storage.clearStorage();
    final firstLaunch = await storage.isFirstLaunch();

    if (firstLaunch) {
      // access to device dark theme
      const darkMode = ThemeMode.system == ThemeMode.dark;
      // access to device language
      await storage.setConfig(language: getDeviceLanguage(), darkMode: darkMode);

      Future.delayed(Duration(milliseconds: pageConfig["duration"]), () {
        context.go("/boarding");
      });
    } else {
      final config = await storage.getConfig();

      if (config["language"] == null) {
        storage.setConfig(language: getDeviceLanguage());
      }

      if (config["darkMode"] == null) {
        const darkMode = ThemeMode.system == ThemeMode.dark;
        await storage.setConfig(darkMode: darkMode);
      }
      GoRouter.of(context).replace("/home");
    }
  }

  getDeviceLanguage() {
    final String defaultLocale;
    if (!kIsWeb) {
      defaultLocale = Platform.localeName;
    } else {
      defaultLocale = "en";
    }
    final langParts = defaultLocale.split("_");
    final supportedLanguages = ["en", "tr", "it", "fr", "es", "de"];

    final String finalLang;

    if (supportedLanguages.contains(langParts[0])) {
      finalLang = langParts[0];
    } else {
      finalLang = "en";
    }

    return finalLang;
  }

  @override
  void initState() {
    super.initState();
    clientCubit = context.read<ClientCubit>();
    loadApp();
  }

  @override
  Widget build(BuildContext context) {
    return !configLoader
        ? const SizedBox()
        : Scaffold(
            body: SafeArea(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: pageConfig["backgroundColor"].isNotEmpty
                      ? HexColor(pageConfig["backgroundColor"])
                      : null,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          pageConfig["logo"],
                          width: 150,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
