import 'package:flutter/cupertino.dart';
import 'package:news/core/routes/route_names.dart';
import 'package:news/ui/home%20screen/home_screen.dart';

abstract class Routes {
  static Map<String, Widget Function(BuildContext)> myAppRoutes = {
    RouteNames.homeScreen: (_) => HomeScreen(),
  };
}
