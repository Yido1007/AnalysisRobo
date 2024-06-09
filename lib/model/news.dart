class Article {
  final String title;
  final String publishedAt;
  final String urlToImage;

  Article({required this.title, required this.publishedAt, required this.urlToImage});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      publishedAt: json['publishedAt'],
      urlToImage: json['urlToImage'] ?? '',
    );
  }
}
