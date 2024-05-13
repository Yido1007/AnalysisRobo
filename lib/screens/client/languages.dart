import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../bloc/client/client_cubit.dart';
import '../../core/localizations.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
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
          // language screen title
          title: Text(
            AppLocalizations.of(context).getTranslate("language"),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              // prints the current status
              // Text(
              //     "${AppLocalizations.of(context).getTranslate("language")}: ${clientCubit.state.language}"),
              const Gap(25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // to use Tr
                  InkWell(
                    child: Image.asset(
                      "assets/icons/turkey.png",
                      width: 80,
                    ),
                    onTap: () {
                      clientCubit.state.language == "tr"
                          ? null
                          : (
                              {
                                clientCubit.changeLanguage(language: "tr"),
                              },
                            );
                    },
                  ),
                  // to use En
                  InkWell(
                    child: Image.asset(
                      "assets/icons/england.png",
                      width: 80,
                    ),
                    onTap: () {
                      clientCubit.state.language == "en"
                          ? null
                          : (
                              {
                                clientCubit.changeLanguage(language: "en"),
                              },
                            );
                    },
                  ),
                ],
              ),
              const Gap(25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // to use Esp
                  InkWell(
                    child: Image.asset(
                      "assets/icons/spain.png",
                      width: 80,
                    ),
                    onTap: () {
                      clientCubit.state.language == "es"
                          ? null
                          : (
                              {
                                clientCubit.changeLanguage(language: "es"),
                              },
                            );
                    },
                  ),
                  // to use Fra
                  InkWell(
                    child: Image.asset(
                      "assets/icons/france.png",
                      width: 80,
                    ),
                    onTap: () {
                      clientCubit.state.language == "fr"
                          ? null
                          : (
                              {
                                clientCubit.changeLanguage(language: "fr"),
                              },
                            );
                    },
                  ),
                ],
              ),
              const Gap(25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // to use De
                  InkWell(
                    child: Image.asset(
                      "assets/icons/germany.png",
                      width: 80,
                    ),
                    onTap: () {
                      clientCubit.state.language == "de"
                          ? null
                          : (
                              {
                                clientCubit.changeLanguage(language: "de"),
                              },
                            );
                    },
                  ),
                  // to use It
                  InkWell(
                    child: Image.asset(
                      "assets/icons/italy.png",
                      width: 80,
                    ),
                    onTap: () {
                      clientCubit.state.language == "it"
                          ? null
                          : (
                              {
                                clientCubit.changeLanguage(language: "it"),
                              },
                            );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
