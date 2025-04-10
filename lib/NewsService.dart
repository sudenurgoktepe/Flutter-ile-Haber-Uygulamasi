import 'dart:convert';
import 'package:haberuygulama/Result.dart';
import 'package:haberuygulama/News.dart';
import 'package:http/http.dart' as http;

class NewsService {
  Future<List<Result>> fetchNews(String category) async {

    String url = 'https://api.collectapi.com/news/getNews?country=tr&tag=$category';

    Map<String, String> headers = {
      'authorization': 'apikey 3Wiya3VB9tl97jAB5O4dwH:7l3hPPizmBZDxwm5anzdOb',
      'content-type': 'application/json'
    };

    Uri uri = Uri.parse(url);
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      News news = News.fromJson(result);
      return news.result ?? [];
    } else {
      throw Exception("Bad Request");
    }

  }
}
