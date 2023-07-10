import 'package:dio/dio.dart';
import 'package:nike_store/common/response_validator.dart';

import '../cart_item.dart';
import '../add_to_cart.dart';
import '../cart_response.dart';

abstract class ICartDataSource {
  Future<AddToCartResponseEntity> add(int productId);
  Future<CartResponse> getAll();
  Future<AddToCartResponseEntity> changeCount();
  Future<int> count();
  Future<void> delete();
}

class CardRemoteDataSource implements ICartDataSource {
  final Dio httpClient;

  CardRemoteDataSource(this.httpClient);

  @override
  Future<AddToCartResponseEntity> add(int productId) async {
    final response =
        await httpClient.post("cart/add", data: {"product_id": productId});
    return AddToCartResponseEntity.fromJson(response.data);
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
  Future<void> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<CartResponse> getAll() async {
    final response = await httpClient.get("cart/list");

    return CartResponse.fromJson(response.data);
  }
}
