import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/model/source_response.dart';
import 'package:news/ui/home%20screen/category%20details/news/news_details.dart';
import 'package:news/ui/home%20screen/category%20details/tabs/source_tab_name.dart';


class SourceTabBar extends StatefulWidget {
  final List<Sources> sources;
  const SourceTabBar({super.key, required this.sources});

  @override
  State<SourceTabBar> createState() => _SourceTabBarState();
}

class _SourceTabBarState extends State<SourceTabBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    // DefaultTabController MUST wrap the whole structure.
    return DefaultTabController(
      length: widget.sources.length,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TabBar(
              isScrollable: true,
              padding: EdgeInsets.zero,
              tabAlignment: TabAlignment.start,
              labelPadding: const EdgeInsets.only(right: 15),
              indicatorColor: Theme.of(context).indicatorColor,
              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
              onTap: (index) {
                if (selectedIndex != index) {
                  setState(() {
                    selectedIndex = index;
                  });
                }
              },
              tabs: widget.sources
                  .map(
                    (e) => SourceTabName(
                  sources: e,
                  isSelected:
                  widget.sources.indexOf(e) == selectedIndex,
                ),
              )
                  .toList(),
            ),
          ),
          SizedBox(height: height * 0.01),
          // 👇 This needs to be wrapped in Expanded to give TabBarView space
          Expanded(
            child: TabBarView(
              children: widget.sources
                  .map((source) => NewsDetails(source: source))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}


// class SourceTabBar extends StatefulWidget {
//   final List<Sources> sources;
//   const SourceTabBar({super.key, required this.sources});
//
//   @override
//   State<SourceTabBar> createState() => _SourceTabBarState();
// }
//
// class _SourceTabBarState extends State<SourceTabBar> {
//   int selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return Column(
//       children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               children: [
//                 DefaultTabController(
//                   length: widget.sources.length,
//                   child: Column(
//                     children: [
//                       TabBar(
//                         isScrollable: true,
//                         padding: EdgeInsets.zero,
//                         tabAlignment: TabAlignment.start,
//                         labelPadding: EdgeInsets.only(right: 15),
//                         indicatorColor: Theme.of(context).indicatorColor,
//                         overlayColor: WidgetStatePropertyAll(Colors.transparent),
//                         onTap: (index) {
//                           if(selectedIndex != index){
//                             selectedIndex = index;
//                             setState(() {});
//                           }
//                         },
//                         tabs:
//                             widget.sources
//                                 .map(
//                                   (e) => SourceTabName(
//                                     sources: e,
//                                     isSelected: widget.sources.indexOf(e) == selectedIndex,
//                                   ),
//                                 )
//                                 .toList(),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: height*0.01),
//                 // NewsDetails(source: widget.sources[selectedIndex]),
//
//                 Expanded(
//                   child: TabBarView(
//                     children: widget.sources
//                         .map((source) => NewsDetails(source: source))
//                         .toList(),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
