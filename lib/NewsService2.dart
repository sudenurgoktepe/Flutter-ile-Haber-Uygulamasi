import 'dart:convert';

import 'package:haberuygulama/Result.dart';
import 'package:haberuygulama/news.dart';
import 'package:http/http.dart' as http;

class NewService2{
  Future<List<Result>> Habericek(String category) async{
    String url = 'https://api.collectapi.com/news/getNews?country=de&tag=$category';

    Map<String, String> header = {
      'authorization': 'apikey 3Wiya3VB9tl97jAB5O4dwH:7l3hPPizmBZDxwm5anzdOb',
      'content-type': 'application/json'
    };
    Uri uri = Uri.parse(url);
    final cevap = await http.get(uri, headers: header);
    if(cevap.statusCode==200){
      final sonuc = json.decode(cevap.body);
      News news = News.fromJson(sonuc);
      return news.result ?? [];
    }
    throw Exception("Bad Request");



  }

}