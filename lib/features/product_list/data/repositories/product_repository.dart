// json_serializable, dio
// call api from "/products"

import 'package:flutter_test_myeg/core/utils/data_result_model.dart';
import 'package:flutter_test_myeg/core/utils/network_helper.dart';
import 'package:flutter_test_myeg/features/product_list/data/models/product_model.dart';

class ProductRepository {
  final NetworkHelper _networkHelper;

  ProductRepository() : _networkHelper = NetworkHelper();

  Future<DataResultModel<List<ProductModel>>> getProducts() async {
    final response = await _networkHelper.get('/products');

    final List<ProductModel> products = (response.data as List).map((e) => ProductModel.fromJson(e)).toList();

    return DataResultModel<List<ProductModel>>(data: products, message: "Products fetched successfully", success: true);
  }
}
