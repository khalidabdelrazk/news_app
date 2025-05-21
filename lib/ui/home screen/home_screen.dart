import 'package:flutter/material.dart';
import 'package:news/core/assets/my_images.dart';
import 'package:news/ui/common/custom_text_field.dart';
import 'package:news/ui/home%20screen/category%20details/categories.dart';
import 'package:news/ui/home%20screen/category%20details/tabs/category_details.dart';
import 'package:news/ui/home%20screen/drawer/my_drawer.dart';

import '../../model/category_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? sourceId;
  // TextEditingController searchController = TextEditingController();
  bool _isSearching = false;
  late double width;
  late double height;

  searchBar() {
    return SizedBox(
      width: width,
      height: height*0.08,
      child: CustomTextField(
        controller: MyImages.searchController,
        label: 'Search',
        prefixIcon: Icons.search,
        suffixIcon: Icons.close,
        onSuffixPressed: () {
          MyImages.searchController.clear();
          _isSearching = !_isSearching;
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: MyDrawer(onTap: (p0) => categoryAndGoToHomePressed(p0)),
      appBar: AppBar(
        toolbarHeight: height*0.09,
        title: _isSearching ? searchBar() : Text('Home'),
        forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
        leading:  !_isSearching ? Builder(
          builder: (context) {
            return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu),
                );
          },
        ) : null,
        actions: [
          _isSearching
              ? SizedBox.shrink()
              : IconButton(
                onPressed: sourceId != null
                    ?() {
                  _isSearching = !_isSearching;
                  setState(() {});
                }: null,
                icon: Icon(Icons.search),
              ),
        ],
      ),
      body:
          sourceId != null
              ? CategoryDetails(sourceId: sourceId!)
              : Categories(
                category: CategoryModel.getCategoryList(),
                onPressed: (p0) => categoryAndGoToHomePressed(p0),
              ),
    );
  }

  void categoryAndGoToHomePressed(String? id) {
    sourceId = id;
    setState(() {});
  }
}
