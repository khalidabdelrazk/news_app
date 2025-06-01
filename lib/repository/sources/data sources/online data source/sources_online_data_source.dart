import '../../../../model/source_response.dart';

abstract class SourcesOnlineDataSource {
  Future<SourceResponse?> getSources(String newsId,String lang);
}
