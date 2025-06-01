import '../../../../model/news_response.dart';
import '../../../../model/source_response.dart';

abstract class NewsOfflineDataSource {
  Future<NewsResponse?> getNews(String newsId);
  void saveNews(NewsResponse newsResponse, String newsId, int page);
}
