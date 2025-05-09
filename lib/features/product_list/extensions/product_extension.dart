extension ProductCategoryExtension on String {
  String get displayName {
    return split(' ')
        .map((word) {
          if (word.isEmpty) return '';
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }
}

extension ProductPriceExtension on double {
  String get displayPrice {
    return 'RM${toStringAsFixed(2)}';
  }
}
