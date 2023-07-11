import 'package:nike_store/common/http_baseUrl.dart';

import '../add_to_cart.dart';
import '../cart_response.dart';
import '../source/cart_dataSource.dart';

final cartRepository = CartRepository(CardRemoteDataSource(httpClient));

abstract class ICartRepository {
  Future<AddToCartResponseEntity> add(int productId);
  Future<CartResponse> getAll();
  Future<AddToCartResponseEntity> changeCount();
  Future<int> count();
  Future<void> delete(int cartId);
}

class CartRepository implements ICartRepository {
  final ICartDataSource dataSource;

  CartRepository(this.dataSource);
  @override
  Future<AddToCartResponseEntity> add(int productId) {
    return dataSource.add(productId);
  }

  @override
  Future<AddToCartResponseEntity> changeCount() {
    // TODO: implement changeCount
    throw UnimplementedError();
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int cartId) {
    return dataSource.delete(cartId);
  }

  @override
  Future<CartResponse> getAll() => dataSource.getAll();
}
