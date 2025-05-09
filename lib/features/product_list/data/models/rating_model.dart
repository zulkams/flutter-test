import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class RatingModel {
  @HiveField(0)
  final double? rate;
  @HiveField(1)
  final int? count;

  RatingModel({this.rate, this.count});

  factory RatingModel.fromJson(Map<String, dynamic> json) => _$RatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingModelToJson(this);
}
