import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/model/news_response.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsBottomSheet extends StatelessWidget {
  final Articles? article;
  const NewsBottomSheet({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        // height: height * 0.55,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(9),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl: article?.urlToImage ?? '',
                fit: BoxFit.cover,
                height: height * 0.35,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                article?.description ?? '',
                style: TextTheme.of(context).displayMedium,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(width*0.9, height*0.07)
              ),
                onPressed: () async{
                  var url = Uri.parse(article?.url ?? '');
                  if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
                  throw Exception('Could not launch $url');
                  }

            }, child: Text('View Full Article'))
          ],
        ),
      ),
    );
  }
}
