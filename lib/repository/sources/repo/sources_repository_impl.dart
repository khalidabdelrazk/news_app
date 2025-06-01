import 'package:news/repository/sources/data%20sources/online%20data%20source/sources_online_data_source.dart';
import 'package:news/repository/sources/repo/sources_repository.dart';

import '../../../model/source_response.dart';

class SourcesRepositoryImpl implements SourcesRepository {
  final SourcesOnlineDataSource sourcesOnlineDataSource;
  SourcesRepositoryImpl(this.sourcesOnlineDataSource);
  @override
  Future<SourceResponse?> getSources(String newsId, String lang) {
    // TODO: implement getSources
    return sourcesOnlineDataSource.getSources(newsId, lang);
  }
}
