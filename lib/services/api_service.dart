import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class ApiService {
  static const String _baseUrl = "https://finnhub.io/api/v1/news";
  static const String _apiKey = "crals9pr01qhk4bqotb0crals9pr01qhk4bqotbg";

  Future<List<NewsModel>> fetchNews() async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl?category=general&token=$_apiKey"));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => NewsModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch news');
      }
    } catch (error) {
      throw Exception('Error fetching news: $error');
    }
  }
}
