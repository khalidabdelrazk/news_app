import '../../../model/source_response.dart';

abstract class SourcesRepository{
  Future<SourceResponse?> getSources(String newsId,String lang);
}