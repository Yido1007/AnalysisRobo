import 'package:analysisrobo/bloc/client/client_cubit.dart';
import 'package:analysisrobo/core/localizations.dart';
import 'package:analysisrobo/widgets/downmenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({super.key});

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
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
          title: Text(AppLocalizations.of(context).getTranslate("exchange")),
          centerTitle: true,
        ),
        body: const SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Text("Exchange Screen"),
              ),
              DownMenu()
            ],
          ),
        ),
      );
    });
  }
}
