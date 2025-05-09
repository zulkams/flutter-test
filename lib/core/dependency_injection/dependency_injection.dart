import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test_myeg/features/cart/data/models/cart_item_model.dart';
import 'package:flutter_test_myeg/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter_test_myeg/features/product_list/data/models/product_model.dart';
import 'package:flutter_test_myeg/features/product_list/data/models/rating_model.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_test_myeg/features/product_list/data/repositories/product_repository.dart';
import 'package:flutter_test_myeg/features/product_list/presentation/cubit/product_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // env
  await dotenv.load(fileName: ".env");

  //register repositories
  getIt.registerLazySingleton<ProductRepository>(() => ProductRepository());

  // register product cubit
  getIt.registerFactory(() => ProductCubit(getIt<ProductRepository>()));
  getIt.registerFactory(() => CartCubit());

  // hive
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(RatingModelAdapter());

  if (!Hive.isBoxOpen('cartBox')) {
    await Hive.openBox<Map>('cartBox');
  }
}
