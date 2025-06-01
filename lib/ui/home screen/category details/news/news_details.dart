import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/assets/my_images.dart';
import 'package:news/core/theme/app_theme.dart';
import 'package:news/model/news_response.dart';
import 'package:news/model/source_response.dart';

import 'package:news/ui/home%20screen/category%20details/news/news_bottom_sheet.dart';
import 'package:news/ui/home%20screen/category%20details/news/news_card.dart';
import 'package:provider/provider.dart';
import '../../../../core/provider/language_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../view model/home_states.dart';
import '../../../../view model/home_view_model.dart';

class NewsDetails extends StatefulWidget {
  final Sources source;
  const NewsDetails({super.key, required this.source});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  int page = 1;
  List<Articles> articles = [];
  bool isInitialized = false;

  late LanguageProvider languageProvider;
  final ScrollController listViewController = ScrollController();
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      languageProvider = Provider.of<LanguageProvider>(context, listen: false);
      homeViewModel.getNews(
        widget.source.id!,
        languageProvider.selectedLanguage,
        MyImages.searchController.text,
      );
      isInitialized = true;
    }
  }

  @override
  void initState() {
    super.initState();
    listViewController.addListener(() {
      if (listViewController.position.pixels >=
          listViewController.position.maxScrollExtent&&
          !homeViewModel.isLoadingMore &&
          homeViewModel.hasMore) {
        homeViewModel.fetchMoreNews(
          widget.source.id!,
          languageProvider.selectedLanguage,
          MyImages.searchController.text,
        );
      }
    });

    MyImages.searchController.addListener(onSearchTextChanged);
  }

  @override
  void dispose() {
    listViewController.dispose();
    MyImages.searchController.removeListener(onSearchTextChanged);
    super.dispose();
  }

  void onSearchTextChanged() {
    page = 1;
    articles.clear();
    homeViewModel.getNews(
      widget.source.id!,
      languageProvider.selectedLanguage,
      MyImages.searchController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeStates>(
      bloc: homeViewModel,
      builder: (context, state) {
        if (state is ErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.error, style: AppTheme.lightBold20),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    homeViewModel.getNews(
                      widget.source.id!,
                      languageProvider.selectedLanguage,
                      MyImages.searchController.text,
                    );
                  },
                  child: Text('Try Again'),
                ),
              ],
            ),
          );
        } else if (state is NewsSuccessState) {
          articles = state.articles;
          return buildListView();
        } else if (state is FetchingMoreNews) {
          articles.addAll(state.articles);
          return buildListView();
        } else {
          return Center(
            child: CircularProgressIndicator(color: AppColors.lightGray),
          );
        }
      },
    );
  }

  Widget buildListView() {
    return ListView.builder(
      controller: listViewController,
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: articles.length + (homeViewModel.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == articles.length) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.lightGray,
              ),
            ),
          );
        }

        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (context) {
                return NewsBottomSheet(article: articles[index]);
              },
            );
          },
          child: NewsCard(article: articles[index]),
        );
      },
    );
  }
}

