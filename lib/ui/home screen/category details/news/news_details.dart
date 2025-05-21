import 'package:flutter/material.dart';
import 'package:news/api/api_manger.dart';
import 'package:news/core/assets/my_images.dart';
import 'package:news/core/theme/app_theme.dart';
import 'package:news/model/news_response.dart';
import 'package:news/model/source_response.dart';
import 'package:news/ui/home%20screen/category%20details/news/news_bottom_sheet.dart';
import 'package:news/ui/home%20screen/category%20details/news/news_card.dart';
import 'package:provider/provider.dart';
import '../../../../core/provider/language_provider.dart';
import '../../../../core/theme/app_colors.dart';

class NewsDetails extends StatefulWidget {
  final Sources source;
  const NewsDetails({super.key, required this.source});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  int page = 1;
  bool isLoadingMore = false;
  bool hasMore = true;
  late LanguageProvider languageProvider;

  List<Articles> articles = [];
  late Future<void> initialFetchFuture;

  final ScrollController listViewController = ScrollController();

  bool _isFirstBuild = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isFirstBuild) {
      languageProvider = Provider.of<LanguageProvider>(context, listen: false);
      initialFetchFuture = fetchInitialNews();
      _isFirstBuild = false;
    }
  }

  @override
  void initState() {
    super.initState();
    listViewController.addListener(() {
      if (listViewController.position.pixels >=
              listViewController.position.maxScrollExtent - 100 &&
          !isLoadingMore &&
          hasMore) {
        fetchMoreNews();
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
    setState(() {
      page = 1;
      hasMore = true;
      articles.clear();
      initialFetchFuture = fetchInitialNews();
    });
  }

  Future<void> fetchInitialNews() async {
    final response = await ApiManager.getNews(
      widget.source.id ?? '',
      languageProvider.selectedLanguage,
      page: page,
      controller: MyImages.searchController.text,
    );
    if (response != null && response.status == 'ok') {
      articles = response.articles ?? [];
      page++;
    }
  }

  Future<void> fetchMoreNews() async {
    setState(() => isLoadingMore = true);

    final response = await ApiManager.getNews(
      widget.source.id ?? '',
      languageProvider.selectedLanguage,
      page: page,
      controller: MyImages.searchController.text,
    );
    if (response != null && response.status == 'ok') {
      final newArticles = response.articles ?? [];
      if (newArticles.isEmpty) {
        hasMore = false;
      } else {
        articles.addAll(newArticles);
        page++;
      }
    }

    setState(() => isLoadingMore = false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialFetchFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.lightGray),
          );
        }

        if (snapshot.hasError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Error!! Please try again", style: AppTheme.lightBold20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    initialFetchFuture = fetchInitialNews();
                  });
                },
                child: Text('Try Again'),
              ),
            ],
          );
        }

        if (articles.isEmpty) {
          return Center(
            child: Text("No Data Available", style: AppTheme.lightBold20),
          );
        }

        return ListView.builder(
          controller: listViewController,
          padding: EdgeInsets.symmetric(horizontal: 20),
          itemCount: articles.length + (isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == articles.length) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.lightGray),
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
      },
    );
  }
}

// class NewsDetails extends StatefulWidget {
//   final Sources source;
//   const NewsDetails({super.key, required this.source});
//
//   @override
//   State<NewsDetails> createState() => _NewsDetailsState();
// }
//
// class _NewsDetailsState extends State<NewsDetails> {
//   int page = 1;
//   bool isFetched = false;
//   late List<Articles>? articles = [];
//
//   ScrollController listViewController = ScrollController();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     listViewController.addListener(() {
//       if(listViewController.position.pixels >= listViewController.position.maxScrollExtent - 30 && !isFetched){
//         page++;
//         fetchNews();
//       }
//     },);
//   }
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return FutureBuilder(
//       future: ApiManager.getNews(widget.source.id ?? '',page: page),
//       builder: (context, snapshot) {
//         // todo : loading Data
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(color: AppColors.lightGray),
//           );
//         }
//
//         // todo : Network Error
//         if (snapshot.hasError) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("Error!! pls Try agn", style: AppTheme.lightBold20),
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {});
//                 },
//                 child: Text('Try Again'),
//               ),
//             ],
//           );
//         }
//
//         // todo : Server Error
//         if (snapshot.data?.status != 'ok') {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(snapshot.data?.message ?? '', style: AppTheme.lightBold20),
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {});
//                 },
//                 child: Text('Try Again'),
//               ),
//             ],
//           );
//         }
//         if (snapshot.data?.articles?.isEmpty ?? false) {
//           return Expanded(
//             child: Center(
//               child: Text(
//                 "No Data Available",
//                 style: TextTheme.of(context).bodyLarge,
//               ),
//             ),
//           );
//         }
//
//         articles?.addAll(snapshot.data!.articles ?? []);
//         return dataAppears();
//       },
//     );
//   }
//
//  dataAppears(){
//     return articles!.isEmpty && isFetched
//         ? Center(child: CircularProgressIndicator(color: AppColors.lightGray))
//         : ListView.builder(
//               controller: listViewController,
//               itemCount: articles!.length + 1, // +1 for loader at end
//               padding: EdgeInsets.symmetric(vertical: 10),
//               itemBuilder: (context, index) {
//         if (index == articles!.length) {
//           return isFetched
//               ? Center(child: CircularProgressIndicator())
//               : SizedBox.shrink();
//         }
//         return GestureDetector(
//           onTap: () {
//             showModalBottomSheet(
//               context: context,
//               isScrollControlled: true,
//               backgroundColor: Colors.transparent,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//               ),
//               builder: (context) {
//                 return NewsBottomSheet(article: articles![index]);
//               },
//             );
//           },
//           child: NewsCard(article: articles![index]),
//         );
//               },
//             );
//   }
//
//   Future<void> fetchNews() async {
//     setState(() {
//       isFetched = true;
//     });
//     print(page.toString() +'<<<<<<====== ');
//
//     final response = await ApiManager.getNews(widget.source.id ?? '', page: page);
//
//     if (response != null && response.status == 'ok') {
//       setState(() {
//         articles?.addAll(response.articles ?? []);
//       });
//     }
//
//     setState(() {
//       isFetched = false;
//     });
//   }
// }
