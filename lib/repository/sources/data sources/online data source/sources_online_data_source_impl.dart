import 'package:news/api/api_manger.dart';
import 'package:news/repository/sources/data%20sources/online%20data%20source/sources_online_data_source.dart';

import '../../../../model/source_response.dart';

class SourcesOnlineDataSourceImpl implements SourcesOnlineDataSource {
  final ApiManager apiManager;
  SourcesOnlineDataSourceImpl(this.apiManager);

  @override
  Future<SourceResponse?> getSources(String newsId, String lang) async{
    // TODO: implement getSources
    var response = await apiManager.getSources(newsId, lang);
    return response;
  }
}
