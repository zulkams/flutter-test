// data result model
import 'package:json_annotation/json_annotation.dart';

part 'data_result_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class DataResultModel<T> {
  final T? data;
  final String? message;
  final bool success;

  DataResultModel({this.data, this.message, required this.success});

  factory DataResultModel.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$DataResultModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T) toJsonT) => _$DataResultModelToJson(this, toJsonT);
}
