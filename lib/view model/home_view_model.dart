import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/di/di.dart';
import 'package:news/model/news_response.dart';
import 'package:news/repository/sources/repo/sources_repository.dart';
import '../repository/news/repo/news_repository.dart';
import 'home_states.dart';

class HomeViewModel extends Cubit<HomeStates> {
  late SourcesRepository sourcesRepository = getSourceRepository();
  late NewsRepository newsRepository = getNewsRepository();

  HomeViewModel() : super(ShowLoadingState());
  List<Articles> myArticles = [];
  final ScrollController listViewController = ScrollController();

  // todo : Get Sources
  getSources(String newsId, String lang) async {
    try {
      emit(ShowLoadingState());
      var response = await sourcesRepository.getSources(newsId, lang);
      if (response?.status == 'error') {
        // todo: Error!!
        emit(ErrorState(response!.message!));
        return;
      } else if (response?.status == 'ok') {
        // todo: Success ♥
        emit(SourcesSuccessState(response!.sources!));
        return;
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  // todo : Get News
  getNews(String sourceId, String lang, String controller) async {
    // hasMore = true;
    try {
      emit(ShowLoadingState());
      var response = await newsRepository.getNews(
        sourceId,
        lang,
        controller: controller,
        page: 1,
      );
      if (response?.status == 'error') {
        // todo: error!!
        emit(ErrorState(response!.message!));
        return;
      } else if (response?.status == 'ok') {
        // todo: success ♥
        myArticles.addAll(response!.articles!);
        emit(NewsSuccessState(response.articles!));
        return;
      }
    } catch (e) {
      // errorMessage = e.toString();
      emit(ErrorState(e.toString()));
    }
  }

  int page = 1;
  bool isLoadingMore = false;
  bool hasMore = true;
  Future<void> fetchMoreNews(
    String sourceId,
    String lang,
    String controller,
  ) async {
    if (!hasMore) {
      return;
    }
    isLoadingMore = true;
    emit(FetchingMoreNews(myArticles));
    try {
      final response = await newsRepository.getNews(
        sourceId,
        lang,
        page: ++page,
        controller: controller,
      );
      if (response != null && response.status == 'ok') {
        final newArticles = response.articles ?? [];
        if (newArticles.isEmpty) {
          isLoadingMore = false;
          hasMore = false;
          emit(NoMoreNews(myArticles));
        } else {
          isLoadingMore = false;
          myArticles.addAll(newArticles);
          emit(NewsSuccessState(myArticles));
        }
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
