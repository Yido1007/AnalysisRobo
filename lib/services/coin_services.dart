import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/coin.dart';

class CoinService {
  static const String _baseUrl = 'https://api.coingecko.com/api/v3';

  Future<List<Coin>> fetchCoins() async {
    final response = await http.get(Uri.parse('$_baseUrl/coins/markets?vs_currency=usd'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Coin> coins = body.map((dynamic item) => Coin.fromJson(item)).toList();
      return coins;
    } else {
      throw Exception('Failed to load coins');
    }
  }
}