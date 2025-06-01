import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/provider/language_provider.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/core/theme/app_theme.dart';

import 'package:news/ui/home%20screen/category%20details/tabs/source_tab_bar.dart';

import 'package:provider/provider.dart';

import '../../../../view model/home_states.dart';
import '../../../../view model/home_view_model.dart';

class CategoryDetails extends StatefulWidget {
  final String sourceId;
  const CategoryDetails({super.key, required this.sourceId});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  late LanguageProvider languageProvider;
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    languageProvider = Provider.of<LanguageProvider>(context);
    homeViewModel.getSources(widget.sourceId, languageProvider.selectedLanguage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeViewModel, HomeStates>(
      bloc: homeViewModel,
      builder: (context, state) {
        if (state is ErrorState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Error!! Please try again", style: AppTheme.lightBold20),
              ElevatedButton(
                onPressed: () {
                  homeViewModel.getSources(widget.sourceId, languageProvider.selectedLanguage);
                },
                child: Text('Retry'),
              ),
            ],
          );
        } else if (state is SourcesSuccessState) {
          return SourceTabBar(sources: state.sources);
        } else {
          return Center(
            heightFactor: MediaQuery.of(context).size.height,
            child: CircularProgressIndicator(color: AppColors.lightGray),
          );
        }
      },
    );
  }
}