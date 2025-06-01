import 'package:hive/hive.dart';
import 'package:news/repository/sources/data%20sources/offline%20data%20source/sources_offline_data_source.dart';
import 'package:news/repository/sources/data%20sources/online%20data%20source/sources_online_data_source.dart';
import '../../../../model/source_response.dart';

class SourcesOfflineDataSourceImpl implements SourcesOfflineDataSource {
  SourcesOfflineDataSourceImpl();

  @override
  Future<SourceResponse?> getSources(String newsId, String lang) async {
    // TODO: implement getSources
    var box = await Hive.openBox('tabs');
    print("${SourceResponse.fromJson(await box.get(newsId)).status}");
    SourceResponse? response = SourceResponse.fromJson(box.get(newsId));
    return response;
  }

  @override
  void saveSources(SourceResponse sourceResponse,String newsId) async {
    // TODO: implement saveSources
    var box = await Hive.openBox('tabs');
    await box.put(newsId, sourceResponse.toJson());
    print("${SourceResponse.fromJson(await box.get(newsId)).status}");
    await box.close();
  }
}
