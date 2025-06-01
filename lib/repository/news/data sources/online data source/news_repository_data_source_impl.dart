import 'package:news/api/api_manger.dart';
import '../../../../model/news_response.dart';
import 'news_repository_data_source.dart';

class NewsOnlineDataSourceImpl implements NewsOnlineDataSource {
  final ApiManager apiManager;
  NewsOnlineDataSourceImpl(this.apiManager);

  @override
  Future<NewsResponse?> getNews(
    String sourceId,
    String lang, {
    int page = 1,
    required String controller,
  }) async {
    // TODO: implement getSources
    var response = await apiManager.getNews(
      sourceId,
      lang,
      controller: controller,
      page: page,
    );
    return response;
  }
}
