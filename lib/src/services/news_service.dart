import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/news_models.dart';

final _URL_NEWS = "https://newsapi.org/v2";
final _APIKEY = "c2a329a6ed544226aeb527432a062e06";

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = "business";

  List<Category> categories = [
    Category(
      FontAwesomeIcons.building,
      "business",
    ),
    Category(
      FontAwesomeIcons.tv,
      "entertainment",
    ),
    Category(
      FontAwesomeIcons.addressCard,
      "general",
    ),
    Category(
      FontAwesomeIcons.headSideVirus,
      "health",
    ),
    Category(
      FontAwesomeIcons.tree,
      "science",
    ),
    Category(
      FontAwesomeIcons.volleyball,
      "sports",
    ),
    Category(
      FontAwesomeIcons.memory,
      "technology",
    )
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();
    categories.forEach((element) {
      this.categoryArticles[element.name] = [];
    });
  }

  String get selectedCategory => this._selectedCategory;

  set selectedCategory(String valor) {
    this._selectedCategory = valor;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }
  List<Article>? get articlesSelectedCategory => this.categoryArticles[this.selectedCategory];

  getTopHeadlines() async {
    final url =
        Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=co');
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category]!.length > 0) {
      return this.categoryArticles[category];
    }

    final url = Uri.parse(
        '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=co&category=$category');
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);
    this.categoryArticles[category]?.addAll(newsResponse.articles);
    notifyListeners();
  }
}
