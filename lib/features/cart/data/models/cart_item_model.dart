import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 2)
class CartItemModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String image;

  CartItemModel({required this.id, required this.title, required this.price, required this.image});
}
