import 'package:flutter/material.dart';
import 'package:news/api/api_manger.dart';
import 'package:news/core/provider/language_provider.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/core/theme/app_theme.dart';
import 'package:news/model/source_response.dart';
import 'package:news/ui/home%20screen/category%20details/tabs/source_tab_bar.dart';
import 'package:provider/provider.dart';

class CategoryDetails extends StatefulWidget {
  final String sourceId;
  const CategoryDetails({super.key, required this.sourceId});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  late LanguageProvider languageProvider;
  @override
  Widget build(BuildContext context) {
    languageProvider = Provider.of<LanguageProvider>(context);
    return FutureBuilder<SourceResponse?>(
      future: ApiManager.getSources(widget.sourceId,languageProvider.selectedLanguage),
      builder: (context, snapshot) {
        // todo : Loading..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            heightFactor: MediaQuery.of(context).size.height,
            child: CircularProgressIndicator(color: AppColors.lightGray),
          );
        }
        // todo : Network Error!!
        else if (snapshot.hasError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Error!! pls Try agn", style: AppTheme.lightBold20),
              ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text('Press'),
              ),
            ],
          );
        }
        // todo : Server Error!!
        else if (snapshot.data?.status != 'ok') {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(snapshot.data!.message!, style: AppTheme.lightBold20),
              ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text('Try Again'),
              ),
            ],
          );
        }
        // todo : Success
        var sourcesList = snapshot.data?.sources ?? [];
        return SourceTabBar(
          sources: sourcesList,
        );
      },
    );
  }
}