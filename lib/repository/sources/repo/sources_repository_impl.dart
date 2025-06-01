import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news/repository/sources/data%20sources/offline%20data%20source/sources_offline_data_source.dart';
import 'package:news/repository/sources/data%20sources/online%20data%20source/sources_online_data_source.dart';
import 'package:news/repository/sources/repo/sources_repository.dart';
import '../../../model/source_response.dart';

class SourcesRepositoryImpl implements SourcesRepository {
  final SourcesOnlineDataSource sourcesOnlineDataSource;
  final SourcesOfflineDataSource sourcesOfflineDataSource;
  SourcesRepositoryImpl(
    this.sourcesOnlineDataSource,
    this.sourcesOfflineDataSource,
  );
  @override
  Future<SourceResponse?> getSources(String newsId, String lang) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.mobile) &&
        !connectivityResult.contains(ConnectivityResult.ethernet) &&
        !connectivityResult.contains(ConnectivityResult.wifi) &&
        !connectivityResult.contains(ConnectivityResult.vpn) &&
        !connectivityResult.contains(ConnectivityResult.bluetooth)) {
      // TODO: getSources online & save Sources
      print("net not ok");
      return sourcesOfflineDataSource.getSources(newsId, lang);
    }
    var response = await sourcesOnlineDataSource.getSources(newsId, lang);
    response != null
        ? sourcesOfflineDataSource.saveSources(response, newsId)
        : null;
    print("net ok");
    return sourcesOnlineDataSource.getSources(newsId, lang);

  }
}
