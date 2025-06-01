import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news/repository/news/data%20sources/offline%20data%20source/news_offline_data_source.dart';
import 'package:news/repository/sources/data%20sources/online%20data%20source/sources_online_data_source.dart';
import '../../../model/news_response.dart';
import '../../../model/source_response.dart';
import '../data sources/online data source/news_repository_data_source.dart';
import 'news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsOnlineDataSource newsOnlineDataSource;
  final NewsOfflineDataSource newsOfflineDataSource;
  NewsRepositoryImpl(this.newsOnlineDataSource, this.newsOfflineDataSource);
  @override
  Future<NewsResponse?> getNews(
    String sourceId,
    String lang, {
    int page = 1,
    required String controller,
  }) async {
    // TODO: implement getNews
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.mobile) &&
        !connectivityResult.contains(ConnectivityResult.ethernet) &&
        !connectivityResult.contains(ConnectivityResult.wifi) &&
        !connectivityResult.contains(ConnectivityResult.vpn) &&
        !connectivityResult.contains(ConnectivityResult.bluetooth)){
      return newsOfflineDataSource.getNews(sourceId + page.toString());
    }

    var response = await newsOnlineDataSource.getNews(
      sourceId,
      lang,
      controller: controller,
      page: page,
    );
    response != null
        ? newsOfflineDataSource.saveNews(response, sourceId, page)
        : null;
    return response;
  }
}
