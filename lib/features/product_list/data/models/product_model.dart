import 'package:flutter_test_myeg/features/product_list/data/models/rating_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class ProductModel {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? title;

  @HiveField(2)
  final double? price;

  @HiveField(3)
  final String? description;

  @HiveField(4)
  final String? category;

  @HiveField(5)
  final String? image;

  @HiveField(6)
  final RatingModel? rating;

  ProductModel({this.id, this.title, this.price, this.description, this.category, this.image, this.rating});

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}