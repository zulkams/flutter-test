import 'package:flutter_test_myeg/app.dart';
import 'package:flutter_test_myeg/features/product_list/presentation/screens/product_list_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [GoRoute(path: '/', name: 'productList', builder: (context, state) => BaseScreen(child: ProductListScreen()))],
);
