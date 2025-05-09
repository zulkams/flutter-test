import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_myeg/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter_test_myeg/features/product_list/data/models/product_model.dart';
import 'package:flutter_test_myeg/features/product_list/extensions/product_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1; // Default quantity

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        forceMaterialTransparency: true,
        actionsPadding: const EdgeInsets.only(right: 16),
        actions: [
          BlocBuilder<CartCubit, Map<ProductModel?, int>>(
            builder: (context, cartItems) {
              final totalItems = cartItems.values.fold(0, (sum, quantity) => sum + quantity);
              return GestureDetector(child: Badge(label: Text(totalItems.toString()), child: const Icon(Icons.shopping_cart)), onTap: () => context.pushNamed('cart'));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: buildProductImage()),
            const SizedBox(height: 16),
            buildDetailsSection(),
            const SizedBox(height: 8),
            buildRatingStars(widget.product.rating?.rate, widget.product.rating?.count),
            const SizedBox(height: 8),
            buildAddCartSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Column buildDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.product.title ?? '', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text('Category: ${widget.product.category?.displayName}', style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey)),
        const SizedBox(height: 8),
        Text(widget.product.description ?? '', style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        Text(widget.product.price?.displayPrice ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
      ],
    );
  }

  BlocBuilder<CartCubit, Map<ProductModel?, int>> buildAddCartSection() {
    return BlocBuilder<CartCubit, Map<ProductModel?, int>>(
      builder: (context, cartItems) {
        return Column(
          children: [
            Row(
              children: [
                const Text('Quantity:'),
                const SizedBox(width: 8),
                DropdownButton2<int>(
                  value: quantity,
                  items: List.generate(5, (index) => index + 1).map((value) => DropdownMenuItem(value: value, child: Text(value.toString()))).toList(),
                  dropdownStyleData: DropdownStyleData(decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)), elevation: 2),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() {
                        quantity = newValue;
                      });
                    }
                  },
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12)),
              onPressed: () {
                final cartCubit = context.read<CartCubit>();
                for (int i = 0; i < quantity; i++) {
                  cartCubit.addToCart(widget.product);
                }

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$quantity item(s) added to cart'), duration: const Duration(seconds: 1)));
              },
              child: const Text('Add to Cart'),
            ),
          ],
        );
      },
    );
  }

  PinchZoomReleaseUnzoomWidget buildProductImage() {
    return PinchZoomReleaseUnzoomWidget(
      child: CachedNetworkImage(
        imageUrl: widget.product.image ?? '',
        width: double.infinity,
        height: 250,
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  Widget buildRatingStars(double? rating, int? count) {
    return Row(
      children: [
        Row(
          children: List.generate(5, (index) {
            return Icon(rating != null && index < rating.round() ? Icons.star : Icons.star_border, color: Colors.amber);
          }),
        ),
        if (rating != null) ...[const SizedBox(width: 8), Text(rating.toStringAsFixed(1), style: const TextStyle(fontSize: 16))],
        if (count != null) ...[const SizedBox(width: 8), Text('($count)', style: const TextStyle(fontSize: 16))],
      ],
    );
  }
}
