// product card
import 'package:flutter/material.dart';
import 'package:flutter_test_myeg/features/product_list/data/models/product_model.dart';
import 'package:flutter_test_myeg/features/product_list/extensions/product_extension.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        isThreeLine: true,
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minTileHeight: 200,
        title: Text(product.title ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(product.price?.displayPrice ?? '', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600)), buildRating()],
        ),
        onTap: () => context.pushNamed('productDetails', pathParameters: {'id': product.id.toString()}, extra: product),
      ),
    );
  }

  Row buildRating() {
    return Row(
      children: [
        Text('Rating: '),
        Text('${product.rating?.rate}'),
        const Icon(Icons.star, color: Colors.amber, size: 16),
        SizedBox(width: 1),
        Text('(${product.rating?.count})'),
      ],
    );
  }
}
