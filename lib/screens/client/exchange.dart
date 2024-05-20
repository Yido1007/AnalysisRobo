import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../bloc/client/client_cubit.dart';
import '../../core/coin_provider.dart';
import '../../core/localizations.dart';
import '../../widgets/bottommenu.dart';

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
    return BlocBuilder<ClientCubit, ClientState>(
      builder: (context, state) {
        final coinProvider = Provider.of<CoinProvider>(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).getTranslate("exchange")),
            centerTitle: true,
          ),
          body: coinProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: coinProvider.coins.length,
                  itemBuilder: (context, index) {
                    final coin = coinProvider.coins[index];
                    return ListTile(
                      leading: Image.network(coin.image, width: 40, height: 40),
                      title: Text(coin.name),
                      subtitle: Text(coin.symbol),
                      trailing: Container(
                          padding: const EdgeInsets.all(12),
                          width: 90,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              )),
                          child: Center(
                            child: Text(
                              '\$${coin.price.toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          )),
                    );
                  },
                ),
          bottomNavigationBar: const BottomMenu(),
        );
      },
    );
  }
}
