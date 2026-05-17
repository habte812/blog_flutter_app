class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String categoryImage;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.categoryImage,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      categoryImage: json['category_image_url'],
    );
  }
}
