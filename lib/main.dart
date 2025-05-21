import 'package:flutter/material.dart';
import 'package:news/core/provider/language_provider.dart';
import 'package:news/core/provider/theme_provider.dart';
import 'package:news/core/routes/routes.dart';
import 'package:news/core/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<LanguageProvider>(
          create: (_) => LanguageProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  late ThemeProvider themeProvider;
  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          themeProvider.isDark ? AppTheme().darkTheme : AppTheme().lightTheme,
      routes: Routes.myAppRoutes,
    );
  }
}
