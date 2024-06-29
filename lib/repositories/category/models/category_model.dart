class Category {
  final int categoryId;
  final String title;
  final String? imageUrl;
  final int hasSubcategories;
  final String fullName;
  final String categoryDescription;

  Category({
    required this.categoryId,
    required this.title,
    this.imageUrl,
    required this.hasSubcategories,
    required this.fullName,
    required this.categoryDescription,
  });

  factory Category.fromJSON(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      hasSubcategories: json['hasSubcategories'],
      fullName: json['fullName'],
      categoryDescription: json['categoryDescription'] ?? '',
    );
  }
}
