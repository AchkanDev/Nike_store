import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nike_store/common/appExeption.dart';

import '../product.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getAll(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRemoteDataSource implements IProductDataSource {
  final Dio httpClient;

  ProductRemoteDataSource(this.httpClient);
  @override
  Future<List<ProductEntity>> getAll(int sort) async {
    final productList = <ProductEntity>[];
    final response = await httpClient.get("product/list?sort=$sort");
    validateResponse(response);
    (response.data as List).forEach((element) {
      productList.add(ProductEntity.fromJson(element));
    });
    return productList;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async {
    final productList = <ProductEntity>[];
    final response = await httpClient.get("product/list?q=$search");
    validateResponse(response);
    (response.data as List).forEach((element) {
      productList.add(ProductEntity.fromJson(element));
    });
    return productList;
  }

  void validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppExeption("خطای نامشخص");
    }
  }
}
