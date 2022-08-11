import 'dart:convert';

import 'package:http/http.dart';

import '../models/article_model.dart';

class News {
  List<Article_model> article = [];

  Future<void> getNews() async {
    var url =
        'https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=0684c92663814e6e9132cc4ee781d569';

    Response response = await get(Uri.parse(url));
    var jsondata = jsonDecode(response.body);
    if (jsondata['status'] == 'ok') {
      jsondata['articles'].forEach((element) {
        if (element['urlToImage'] != null || element['description'] != null) {
          Article_model article_model = Article_model(
              element['author'],
              element['title'],
              element['description'],
              element['url'],
              element['urlToImage'],
              element['content']);
          article.add(article_model);
          print('eklendi!');
        }
        print('hata var');
      });
    }
  }
}

class Category_News {
  List<Article_model> article = [];

  Future<void> getNews(String category) async {
    var url =
        'https://newsapi.org/v2/top-headlines?country=tr&category=${category}&apiKey=0684c92663814e6e9132cc4ee781d569';


    var  apiKey='0684c92663814e6e9132cc4ee781d569';
    var url2="http://newsapi.org/v2/top-headlines?country=tr&category=$category&apiKey=${apiKey}";

    Response response = await get(Uri.parse(url2));
    var jsondata = jsonDecode(response.body);
    if (jsondata['status'] == 'ok') {
      jsondata['articles'].forEach((element) {
        if (element['urlToImage'] != null || element['description'] != null) {
          Article_model article_model = Article_model(
              element['author'],
              element['title'],
              element['description'],
              element['url'],
              element['urlToImage'],
              element['content']);
          article.add(article_model);
          print('eklendi!');
        }

      });

    }else
      print('hata var');
  }
}
