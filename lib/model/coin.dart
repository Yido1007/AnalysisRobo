class Coin {
  final String name;
  final String symbol;
  final double price;
  final String image;

  Coin({required this.name, required this.symbol, required this.price, required this.image});

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      name: json['name'],
      symbol: json['symbol'],
      price: json['current_price'].toDouble(),
      image: json['image'],
    );
  }
}
