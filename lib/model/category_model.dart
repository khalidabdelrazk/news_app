import 'package:news/core/assets/my_images.dart';

class CategoryModel {
  static bool isDark = true;
  final String image;
  final String id;
  CategoryModel({required this.image, required this.id});
  static List<CategoryModel> getCategoryList() {
    return [
      CategoryModel(
        image: isDark ? MyImages.darkGeneral : MyImages.lightGeneral,
        id: 'general',
      ),
      CategoryModel(
        image: isDark ? MyImages.darkBusiness : MyImages.lightBusiness,
        id: 'business',
      ),
      CategoryModel(
        image: isDark ? MyImages.darkSport : MyImages.lightSport,
        id: 'sports',
      ),
      CategoryModel(
        image: isDark ? MyImages.darkTechnology : MyImages.lightTechnology,
        id: 'technology',
      ),
      CategoryModel(
        image: isDark ? MyImages.darkScience : MyImages.lightScience,
        id: 'science',
      ),
      CategoryModel(
        image: isDark ? MyImages.darkHealth : MyImages.lightHealth,
        id: 'health',
      ),
    ];
  }
}
