import 'dart:io';

import '../../../model/product.dart';


abstract class ProductRepo {
  Future<List<Product>> getAllProduct();
  Future<bool> addProduct({required Product product, required File? imageFile});
  Future<bool> updateProduct({required Product product, required File? imageFile});
  Future<bool> deleteProduct({required String productId});
}