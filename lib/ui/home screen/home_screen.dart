import 'package:flutter/material.dart';
import 'package:news/core/assets/my_images.dart';
import 'package:news/core/provider/search_provider.dart';
import 'package:news/ui/common/custom_text_field.dart';
import 'package:news/ui/home%20screen/category%20details/categories.dart';
import 'package:news/ui/home%20screen/category%20details/tabs/category_details.dart';
import 'package:news/ui/home%20screen/drawer/my_drawer.dart';
import 'package:provider/provider.dart';

import '../../model/category_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? sourceId;
  late double width;
  late double height;
  Widget? categoryDetailsWidget;
  late SearchProvider searchProvider;

  searchBar() {
    return SizedBox(
      width: width,
      height: height * 0.08,
      child: CustomTextField(
        controller: MyImages.searchController,
        label: 'Search',
        prefixIcon: Icons.search,
        suffixIcon: Icons.close,
        onSuffixPressed: () {
          MyImages.searchController.clear();
          searchProvider.search(false);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    searchProvider = Provider.of<SearchProvider>(context);
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: MyDrawer(onTap: (p0) => categoryAndGoToHomePressed(p0)),
      appBar: AppBar(
        toolbarHeight: height * 0.09,
        title: searchProvider.showSearch ? searchBar() : Text('Home'),
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        leading:
            !searchProvider.isSearching
                ? Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: Icon(Icons.menu),
                    );
                  },
                )
                : null,
        actions: [
          searchProvider.isSearching || sourceId == null
              ? SizedBox.shrink()
              : IconButton(
                onPressed: () {
                  searchProvider.search(true);
                },
                icon: Icon(Icons.search),
              ),
        ],
      ),
      body:
          sourceId != null
              ? categoryDetailsWidget!
              : Categories(
                category: CategoryModel.getCategoryList(),
                onPressed: (p0) => categoryAndGoToHomePressed(p0),
              ),
    );
  }

  void categoryAndGoToHomePressed(String? id) {
    sourceId = id;
    if(id != null){
      categoryDetailsWidget = CategoryDetails(sourceId: id);
    }
    setState(() {});
  }
}
