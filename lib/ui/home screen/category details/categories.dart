import 'package:flutter/material.dart';
import 'package:news/model/category_model.dart';

import '../../../core/theme/app_colors.dart';

class Categories extends StatefulWidget {
  final List<CategoryModel> category;
  final Function(String) onPressed;
  const Categories({
    super.key,
    required this.onPressed,
    required this.category,
  });

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: width * (363 / 393),
              height: height * (198.04 / 852),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.07,
                vertical: height * 0.03,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.category[index].image),
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Container(
                alignment:
                    !(index % 2 == 0)
                        ? Alignment.bottomLeft
                        : Alignment.bottomRight,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.lightGray,
                    side: BorderSide.none,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    widget.onPressed(widget.category[index].id);
                  },
                  child: SizedBox(
                    width: width * 0.35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      textDirection:
                          (index % 2 == 0)
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).cardColor,
                          child: Icon(
                            (index % 2 == 0)
                                ? Icons.arrow_forward_ios
                                : Icons.arrow_back_ios,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Text('View All', style: TextTheme.of(context).bodyMedium),
                        SizedBox(width: width * 0.01),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: height * 0.01);
          },
          padding: EdgeInsets.only(bottom: height*0.03),
          itemCount: widget.category.length,
        ),
      ),
    );
  }
}
