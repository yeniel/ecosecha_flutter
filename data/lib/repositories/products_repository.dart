import 'package:data/data.dart';
import 'package:domain/domain.dart';

class ProductsRepository {
  const ProductsRepository({required this.repository});

  final Repository repository;

  List<Product> get products => (baskets ?? []) + (extras ?? []);

  List<Product>? get baskets {
    if (repository.basketDtoList != null) {
      return Mappers.toProductList(productDtoList: repository.basketDtoList!);
    }

    return null;
  }

  List<Product>? get extras {
    if (repository.extraDtoList != null) {
      return Mappers.toProductList(productDtoList: repository.extraDtoList!);
    }

    return null;
  }

  List<ProductCategory>? get categories {
    if (repository.familyDtoList != null) {
      return Mappers.toCategoryMenuItemList(familyDtoList: repository.familyDtoList!);
    }

    return null;
  }

  List<Product> getProductsOfCategory(ProductCategory category) {
    return extras?.where((product) => product.category == category.id).toList() ?? [];
  }

  List<BasketProduct>? getProductsOfBasket(Product basket) {
    var productDtoList =
        repository.basketProductDtoList?.where((element) => element.basketId == basket.codigo).toList();

    if (productDtoList != null) {
      return Mappers.toBasketProductList(basketProductDtoList: productDtoList, productList: products);
    }

    return null;
  }
}
