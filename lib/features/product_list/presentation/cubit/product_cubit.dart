import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test_myeg/features/product_list/data/models/product_model.dart';
import 'package:flutter_test_myeg/features/product_list/data/repositories/product_repository.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _repository;

  ProductCubit(this._repository) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final result = await _repository.getProducts();
      emit(ProductLoaded(result.data ?? []));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
