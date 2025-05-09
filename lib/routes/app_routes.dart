import 'package:flutter_test_myeg/app.dart';
import 'package:flutter_test_myeg/features/cart/presentation/screens/cart_screen.dart';
import 'package:flutter_test_myeg/features/product_list/data/models/product_model.dart';
import 'package:flutter_test_myeg/features/product_list/presentation/screens/product_details_screen.dart';
import 'package:flutter_test_myeg/features/product_list/presentation/screens/product_list_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'productList',
      builder: (context, state) => BaseScreen(child: ProductListScreen()),
      routes: [
        GoRoute(
          path: 'details/:id',
          name: 'productDetails',
          builder: (context, state) {
            final product = state.extra as ProductModel;
            return BaseScreen(child: ProductDetailsScreen(product: product));
          },
        ),
      ],
    ),
    GoRoute(path: '/cart', name: 'cart', builder: (context, state) => BaseScreen(child: const CartScreen())),
  ],
);
