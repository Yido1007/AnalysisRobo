import 'package:flutter/material.dart';
import '../model/coin.dart';
import '../services/coin_services.dart';

class CoinProvider with ChangeNotifier {
  List<Coin> _coins = [];
  bool _isLoading = false;

  List<Coin> get coins => _coins;
  bool get isLoading => _isLoading;

  CoinProvider() {
    fetchCoins();
  }

  Future<void> fetchCoins() async {
    _isLoading = true;
    notifyListeners();

    _coins = await CoinService().fetchCoins();

    _isLoading = false;
    notifyListeners();
  }
}
