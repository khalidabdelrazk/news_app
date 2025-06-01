import '../../../../model/news_response.dart';

abstract class NewsOnlineDataSource {
  Future<NewsResponse?> getNews(String sourceId,String lang,{int page = 1,required String controller});
}
