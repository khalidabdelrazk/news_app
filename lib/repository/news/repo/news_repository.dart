import '../../../model/news_response.dart';

abstract class NewsRepository{
  Future<NewsResponse?> getNews(String sourceId,String lang,{int page = 1,required String controller});
}