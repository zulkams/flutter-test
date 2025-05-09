import 'package:flutter/material.dart';
import 'package:flutter_test_myeg/features/product_list/presentation/cubit/product_cubit.dart';
import 'package:flutter_test_myeg/features/product_list/presentation/screens/product_list_screen.dart';
import 'package:flutter_test_myeg/routes/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<ProductCubit>(create: (context) => productCubit..fetchProducts())],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
        routerConfig: appRouter,
      ),
    );
  }
}

// base screen
class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(bottom: false, child: child));
  }
}
