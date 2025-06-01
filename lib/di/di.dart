import 'package:news/api/api_manger.dart';
import 'package:news/repository/news/data%20sources/offline%20data%20source/news_offline_data_source.dart';
import 'package:news/repository/news/data%20sources/online%20data%20source/news_repository_data_source.dart';
import 'package:news/repository/news/data%20sources/online%20data%20source/news_repository_data_source_impl.dart';
import 'package:news/repository/news/repo/news_repository.dart';
import 'package:news/repository/news/repo/news_repository_impl.dart';
import 'package:news/repository/sources/data%20sources/offline%20data%20source/sources_offline_data_source.dart';
import 'package:news/repository/sources/data%20sources/online%20data%20source/sources_online_data_source.dart';
import 'package:news/repository/sources/data%20sources/online%20data%20source/sources_online_data_source_impl.dart';
import 'package:news/repository/sources/repo/sources_repository.dart';
import 'package:news/repository/sources/repo/sources_repository_impl.dart';
import '../repository/news/data sources/offline data source/news_offline_data_source_impl.dart';
import '../repository/sources/data sources/offline data source/sources_offline_data_source_impl.dart';

SourcesRepository getSourceRepository() {
  return SourcesRepositoryImpl(
    getSourceOnlineDataSource(),
    getSourceOfflineDataSource(),
  );
}

SourcesOnlineDataSource getSourceOnlineDataSource() {
  return SourcesOnlineDataSourceImpl(getApiManager());
}

SourcesOfflineDataSource getSourceOfflineDataSource() {
  return SourcesOfflineDataSourceImpl();
}

NewsRepository getNewsRepository() {
  return NewsRepositoryImpl(getNewsOnlineDataNews(), getNewsOfflineDataNews());
}

NewsOnlineDataSource getNewsOnlineDataNews() {
  return NewsOnlineDataSourceImpl(getApiManager());
}

NewsOfflineDataSource getNewsOfflineDataNews() {
  return NewsOfflineDataSourceImpl();
}

ApiManager getApiManager() {
  return ApiManager();
}
