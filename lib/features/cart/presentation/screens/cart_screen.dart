import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_myeg/features/cart/presentation/cubit/cart_cubit.dart';

import 'package:flutter_test_myeg/features/product_list/data/models/product_model.dart';
import 'package:flutter_test_myeg/features/product_list/extensions/product_extension.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart'), forceMaterialTransparency: true),
      body: BlocBuilder<CartCubit, Map<ProductModel?, int>>(
        builder: (context, cartItems) {
          if (cartItems.isEmpty) {
            return const Center(child: Text('Cart is empty'));
          }
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems.keys.elementAt(index);
              final quantity = cartItems[item]!;
              return renderCartTile(item, quantity);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CartCubit>().clearCart();
        },
        child: const Icon(Icons.delete),
      ),
    );
  }

  ListTile renderCartTile(ProductModel? item, int quantity) {
    return ListTile(
      leading: CachedNetworkImage(imageUrl: item?.image ?? '', height: 50, width: 50, fit: BoxFit.cover),
      title: Text(item?.title ?? ''),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('Quantity: $quantity'), Text('Price: ${(item?.price ?? 0.0 * quantity).displayPrice}')],
      ),
    );
  }
}
