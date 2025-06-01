import 'package:news/repository/sources/data%20sources/online%20data%20source/sources_online_data_source.dart';
import '../../../model/news_response.dart';
import '../../../model/source_response.dart';
import '../data sources/online data source/news_repository_data_source.dart';
import 'news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsOnlineDataSource sourcesOnlineDataSource;
  NewsRepositoryImpl(this.sourcesOnlineDataSource);
  @override
  Future<NewsResponse?> getNews(
    String sourceId,
    String lang, {
    int page = 1,
    required String controller,
  }) {
    // TODO: implement getSources
    return sourcesOnlineDataSource.getNews(
      sourceId,
      lang,
      controller: controller,
      page: page
    );
  }
}
