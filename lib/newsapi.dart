import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/models/newsmodel.dart';

Future<List<NewsApiModel>> getNews() async {
  Uri url = Uri.parse(
      'https://newsapi.org/v2/everything?q=apple&from=2024-09-26&to=2024-09-26&sortBy=popularity&apiKey=0aca74fe48d4493598ada32dc71ea04f');
  final response = await http.get(url);
  
  if (response.statusCode == 200) {
    Map<String, dynamic> map = jsonDecode(response.body);
    List _articlesList = map['articles'];

    List<NewsApiModel> newsList = _articlesList
        .map((jsondata) => NewsApiModel.fromJson(jsondata))
        .toList();
    return newsList;
  } else {
    print('Error: ${response.statusCode}');
    return [];
  }
}
