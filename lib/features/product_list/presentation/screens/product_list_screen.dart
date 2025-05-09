import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_myeg/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter_test_myeg/features/product_list/data/models/product_model.dart';
import 'package:flutter_test_myeg/features/product_list/extensions/product_extension.dart';
import 'package:flutter_test_myeg/features/product_list/presentation/cubit/product_cubit.dart';
import 'package:flutter_test_myeg/features/product_list/presentation/widgets/product_card.dart';
import 'package:flutter_test_myeg/core/widgets/app_search_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final productCubit = GetIt.instance<ProductCubit>();

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedCategory;
  List<ProductModel> searchedProducts = [];
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  void _onCategoryChanged(String? newCategory) {
    setState(() {
      _selectedCategory = newCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product Lists'),
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
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(children: [Expanded(flex: 1, child: renderCategoryFilter()), const SizedBox(width: 8), Expanded(flex: 9, child: renderSearchBar())]),
              Expanded(
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ProductError) {
                      return renderError(message: state.message);
                    } else if (state is ProductLoaded) {
                      categories = ['All', ...state.products.map((product) => product.category ?? '').where((category) => category.isNotEmpty).toSet()];
                      searchedProducts =
                          state.products.where((product) {
                            final matchesSearch = product.title?.toLowerCase().contains(_searchQuery);
                            final matchesCategory = _selectedCategory == null || _selectedCategory == 'All' || product.category == _selectedCategory;
                            return matchesSearch! && matchesCategory;
                          }).toList();
                      return renderLists(searchedProducts);
                    } else {
                      return renderError();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView renderLists(List<ProductModel> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(product: product);
      },
    );
  }

  Center renderError({String? message}) => Center(child: Text(message ?? 'No products available'));

  AppSearchBar renderSearchBar() {
    return AppSearchBar(
      controller: _searchController,
      onChanged: (query) {
        _onSearchChanged();
      },
      onClear: () {
        setState(() {
          _searchQuery = '';
          _searchController.clear();
        });
      },
    );
  }

  DropdownButtonHideUnderline renderCategoryFilter() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        customButton: Padding(padding: const EdgeInsets.all(8.0), child: const Icon(Icons.filter_list)),
        value: _selectedCategory,
        isExpanded: false,
        isDense: true,
        onChanged: _onCategoryChanged,
        items:
            categories.isEmpty
                ? []
                : categories.map((category) {
                  return DropdownMenuItem<String>(value: category, child: Text(category.displayName));
                }).toList(),

        dropdownStyleData: DropdownStyleData(
          maxHeight: 500,
          width: 200,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
        ),
        menuItemStyleData: const MenuItemStyleData(padding: EdgeInsets.symmetric(horizontal: 12)),
      ),
    );
  }
}
