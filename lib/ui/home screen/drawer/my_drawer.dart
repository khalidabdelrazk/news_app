import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/core/assets/my_images.dart';
import 'package:news/core/provider/language_provider.dart';
import 'package:news/core/provider/theme_provider.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/core/theme/app_theme.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  final Function(String?) onTap;
  const MyDrawer({super.key, required this.onTap});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late ThemeProvider themeProvider;
  late String selectedLanguage;
  late String selectedTheme;
  late LanguageProvider languageProvider;
  late List<String> languageList;

  @override
  void initState() {
    super.initState();
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    selectedTheme = themeProvider.isDark ? 'Dark' : 'Light';
    selectedLanguage = languageProvider.selectedLanguage;
    languageList = languageProvider.possibleLang;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Drawer(
      width: width * 0.75,
      backgroundColor: AppColors.dark,
      child: Column(
        children: [
          Container(
            height: height * 166 / 852,
            width: width,
            color: AppColors.light,
            child: Center(child: Text("News App", style: AppTheme.darkBold20)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              children: [
                SizedBox(height: height * 0.02),
                InkWell(
                  onTap: () {
                    widget.onTap(null);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(MyImages.home),
                      SizedBox(width: width * 0.02),
                      Text("Go To Home", style: AppTheme.lightBold20),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                Divider(
                  height: 2,
                  color: AppColors.light,
                  indent: width * 0.01,
                  endIndent: width * 0.01,
                ),
                SizedBox(height: height * 0.02),

                Row(
                  children: [
                    SvgPicture.asset(MyImages.theme),
                    SizedBox(width: width * 0.02),
                    Text("Theme", style: AppTheme.lightBold20),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  width: width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: AppColors.light),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedTheme,
                      isExpanded: true,
                      dropdownColor: AppColors.dark,
                      borderRadius: BorderRadius.circular(12),
                      style: AppTheme.lightBold20,
                      icon: Icon(Icons.arrow_drop_down, color: AppColors.light),
                      items:
                          ['Dark', 'Light'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue == null) return;

                        setState(() {
                          selectedTheme = newValue;
                        });

                        if (newValue == 'Dark') {
                          themeProvider.setDark();
                        } else {
                          themeProvider.setLight();
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Divider(
                  height: 2,
                  color: AppColors.light,
                  indent: width * 0.01,
                  endIndent: width * 0.01,
                ),
                SizedBox(height: height * 0.02),
                Row(
                  children: [
                    SvgPicture.asset(MyImages.global),
                    SizedBox(width: width * 0.02),
                    Text("Language", style: AppTheme.lightBold20),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  width: width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: AppColors.light),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedLanguage,
                      isExpanded: true,
                      dropdownColor: Colors.black,
                      style: AppTheme.lightBold20,
                      icon: Icon(Icons.arrow_drop_down, color: AppColors.light),
                      items:
                      languageList.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        if(newValue != null){
                          setState(() {
                            selectedLanguage = newValue;
                          });
                          languageProvider.setLang(newValue);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
