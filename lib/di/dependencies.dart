import 'package:news/api/api_manger.dart';
import 'package:news/repository/news/data%20sources/online%20data%20source/news_repository_data_source.dart';
import 'package:news/repository/news/data%20sources/online%20data%20source/news_repository_data_source_impl.dart';
import 'package:news/repository/news/repo/news_repository.dart';
import 'package:news/repository/news/repo/news_repository_impl.dart';
import 'package:news/repository/sources/data%20sources/online%20data%20source/sources_online_data_source.dart';
import 'package:news/repository/sources/data%20sources/online%20data%20source/sources_online_data_source_impl.dart';
import 'package:news/repository/sources/repo/sources_repository.dart';
import 'package:news/repository/sources/repo/sources_repository_impl.dart';

SourcesRepository getSourceRepository() {
  return SourcesRepositoryImpl(getSourceOnlineDataSource());
}

SourcesOnlineDataSource getSourceOnlineDataSource() {
  return SourcesOnlineDataSourceImpl(getApiManager());
}

NewsRepository getNewsRepository() {
  return NewsRepositoryImpl(getNewsOnlineDataNews());
}

NewsOnlineDataSource getNewsOnlineDataNews() {
  return NewsOnlineDataSourceImpl(getApiManager());
}

ApiManager getApiManager() {
  return ApiManager();
}
