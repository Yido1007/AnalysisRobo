import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../core/localizations.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<Article> articles = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  fetchArticles() async {
    const apiKey = 'dd1af8c4ffc642bc9cb05348f24c0283'; // NewsAPI api key
    const url = 'https://newsapi.org/v2/everything?q=cryptocurrency&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          articles =
              List<Article>.from(data['articles'].map((article) => Article.fromJson(article)));
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).getTranslate("news")),
          centerTitle: true,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return ListTile(
                    leading: article.urlToImage.isNotEmpty
                        ? Image.network(article.urlToImage)
                        : const SizedBox.shrink(),
                    title: Text(article.title),
                    subtitle: Text(article.publishedAt),
                    onTap: () {},
                  );
                },
              ),
      ),
    );
  }
}

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
