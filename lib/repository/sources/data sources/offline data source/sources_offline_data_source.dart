import '../../../../model/source_response.dart';

abstract class SourcesOfflineDataSource {
  Future<SourceResponse?> getSources(String newsId, String lang);
  void saveSources(SourceResponse sourceResponse, String newsId);
}
