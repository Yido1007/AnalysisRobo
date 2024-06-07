import 'package:InvenstAnalys/bloc/client/client_cubit.dart';
import 'package:InvenstAnalys/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/localizations.dart';
import 'core/routes.dart';
import 'core/coin_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CoinProvider(),
      child: BlocProvider(
        create: (context) => ClientCubit(
          ClientState(language: "en", darkMode: false),
        ),
        child: BlocBuilder<ClientCubit, ClientState>(
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: routes,
              themeMode: state.darkMode ? ThemeMode.dark : ThemeMode.light,
              theme: lightTheme,
              darkTheme: darkTheme,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('tr', 'TR'),
                Locale('es', 'ES'),
                Locale('de', 'DE'),
                Locale('fr', 'FR'),
                Locale("it", 'IT'),
              ],
              locale: Locale(state.language),
            );
          },
        ),
      ),
    );
  }
}
