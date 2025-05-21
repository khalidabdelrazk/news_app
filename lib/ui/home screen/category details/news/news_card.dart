import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:news/model/news_response.dart';

class NewsCard extends StatefulWidget {
  final Articles? article;
  const NewsCard({super.key, required this.article});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.02),
      child: Container(
        padding: EdgeInsets.all(8),
        width: width * 0.7,
        height: height * 0.4,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).primaryColor, width: 2),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: widget.article?.urlToImage ?? '',
                useOldImageOnUrlChange: true,
                width: width,
                height: height * 0.3,
                fit: BoxFit.cover,
                fadeInDuration: Duration(seconds: 1),
                placeholder:
                    (context, url) =>
                        Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.broken_image),
              ),
            ),
            SizedBox(height: height * 0.01),
            Expanded(
              child: Text(
                widget.article?.title ?? '',
                style: TextTheme.of(
                  context,
                ).bodySmall?.copyWith(overflow: TextOverflow.ellipsis),
                maxLines: 2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.article?.author ?? "",
                    style: TextTheme.of(
                      context,
                    ).headlineSmall?.copyWith(overflow: TextOverflow.ellipsis),
                    softWrap: true,
                    maxLines: 2,
                  ),
                ),
                Text(
                  GetTimeAgo.parse(
                    DateTime.parse(
                      widget.article?.publishedAt ?? DateTime.now().toString(),
                    ),
                  ),
                  style: TextTheme.of(
                    context,
                  ).headlineSmall?.copyWith(overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
