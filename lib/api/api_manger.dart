import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/api/api_constants.dart';
import 'package:news/api/api_end_points.dart';
import 'package:news/model/news_response.dart';
import 'package:news/model/source_response.dart';

class ApiManager {
  // static LanguageProvider languageProvider = LanguageProvider();
  static Future<SourceResponse?> getSources(String newsId,String lang) async {
    Uri url = Uri.https(ApiConstants.apiUrl, ApiEndPoints.sources, {
      'apiKey': ApiConstants.apiKey,
      'category': newsId,
      'language': lang,
    });
    var response = await http.get(url);
    try {
      return SourceResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  static Future<NewsResponse?> getNews(String sourceId,String lang,{int page = 1,required String controller}) async {
    var queryParam = {
      'sources': sourceId,
      'pageSize' : '5',
      'page' : page.toString(),
      'apiKey': ApiConstants.apiKey,
      'language': lang,
    };
    if(controller.trim() != ''){
      queryParam['q'] = controller;
    }
    Uri url = Uri.https(ApiConstants.apiUrl, ApiEndPoints.news, queryParam);
    var response = await http.get(url);
    try {
      return NewsResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
