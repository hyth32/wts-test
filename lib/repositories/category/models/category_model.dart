import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class Category extends Equatable {
  final int categoryId;
  final String title;
  final String? imageUrl;
  final int hasSubcategories;
  final String fullName;
  final String categoryDescription;

  const Category({
    required this.categoryId,
    required this.title,
    required this.hasSubcategories,
    required this.fullName,
    required this.categoryDescription,
    this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  List<Object?> get props => [
        categoryId,
        title,
      ];
}
