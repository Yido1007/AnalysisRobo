import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/client/client_cubit.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
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
          title: const Text(""),
        ),
        body: SafeArea(
          child: SwitchListTile(
            value: clientCubit.state.darkMode,
            onChanged: (value) {
              clientCubit.changeDarkMode(darkMode: value);
            },
            secondary:
                clientCubit.state.darkMode ? const Icon(Icons.sunny) : const Icon(Icons.nightlight),
            title: const Text("dark_mode"),
          ),
        ),
      );
    });
  }
}
