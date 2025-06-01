import 'package:hive/hive.dart';
import 'package:news/model/news_response.dart';
import 'news_offline_data_source.dart';

class NewsOfflineDataSourceImpl implements NewsOfflineDataSource {
  NewsOfflineDataSourceImpl();

  @override
  Future<NewsResponse?> getNews(String newsId) async {
    // TODO: implement getNews
    try{
      var box = await Hive.openBox('News');
      print('failed');
      print(
        "${NewsResponse.fromJson(await box.get(newsId)).status} get correctly",
      );
      NewsResponse? response = NewsResponse.fromJson(box.get(newsId));
      return response;
    }catch(e){
      return null;
    }
  }

  @override
  void saveNews(NewsResponse newsResponse, String newsId, int page) async {
    // TODO: implement saveNews
    var box = await Hive.openBox('News');
    await box.put(newsId + page.toString(), newsResponse.toJson());
    print(
      "${NewsResponse.fromJson(await box.get(newsId + page.toString())).status} saved correctly",
    );
    await box.close();
  }
}
