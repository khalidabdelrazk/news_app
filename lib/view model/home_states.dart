import 'package:news/model/news_response.dart';
import 'package:news/model/source_response.dart';

abstract class HomeStates {}

class ShowLoadingState extends HomeStates {}

class ErrorState extends HomeStates {
  String error;
  ErrorState(this.error);
}

class SourcesSuccessState extends HomeStates {
  List<Sources> sources;
  SourcesSuccessState(this.sources);
}

class NewsSuccessState extends HomeStates {
  List<Articles> articles;
  NewsSuccessState(this.articles);
}

class FetchingMoreNews extends NewsSuccessState {
  FetchingMoreNews(super.articles);
}

class NoMoreNews extends NewsSuccessState {
  NoMoreNews(super.articles);
}

