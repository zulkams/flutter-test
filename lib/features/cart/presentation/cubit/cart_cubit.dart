import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_myeg/features/product_list/data/models/product_model.dart';
import 'package:hive/hive.dart';

class CartCubit extends Cubit<Map<ProductModel?, int>> {
  CartCubit() : super({}) {
    _loadCartFromHive();
  }

  final String _cartBoxName = 'cartBox';
  Box<Map>? _cartBox;

  Future<Box<Map>> _getCartBox() async {
    return _cartBox ??= await Hive.openBox<Map>(_cartBoxName);
  }

  // load
  Future<void> _loadCartFromHive() async {
    emit({});

    final box = await _getCartBox();
    final storedCart = box.get('cart', defaultValue: {});

    if (storedCart != null && storedCart is Map) {
      emit(storedCart.map((key, value) => MapEntry(key as ProductModel, value as int)));
    } else {
      emit({});
    }
  }

  //savee
  Future<void> _saveCartToHive() async {
    final box = await _getCartBox();
    await box.put('cart', state.map((key, value) => MapEntry(key, value)));
  }

  // add to caet
  void addToCart(ProductModel product, {int quantity = 1}) {
    final updatedCart = Map<ProductModel?, int>.from(state);

    final ProductModel? existingProduct = updatedCart.keys.firstWhere((item) => item?.id == product.id, orElse: () => null);

    if (existingProduct != null) {
      updatedCart[existingProduct] = updatedCart[existingProduct]! + quantity;
    } else {
      // add new product
      updatedCart[product] = quantity;
    }
    emit(updatedCart);
    _saveCartToHive();
  }

  void clearCart() {
    emit({});
    _saveCartToHive();
  }

  //combine item
  void combineCartItems() {
    final combinedCart = state.entries.fold<Map<ProductModel?, int>>({}, (acc, entry) {
      final item = entry.key;
      final quantity = entry.value;

      final existingItemList = acc.keys.where((existing) => existing?.id == item?.id).toList();

      if (existingItemList.isNotEmpty) {
        final existingItem = existingItemList.first;
        acc[existingItem] = acc[existingItem]! + quantity;
      } else {
        acc[item] = quantity;
      }

      return acc;
    });

    emit(combinedCart);
    _saveCartToHive();
  }
}
