import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_with_bloc/src/data/model/product_model.dart';
import 'package:flutter/foundation.dart';

class ProductRepository {
  final _fireStore = FirebaseFirestore.instance;

  Future<List<ProductModel>> fetchProducts() async {
    final List<ProductModel> productList = [];

    try {
      final data = await _fireStore.collection('products').get();
      for (var product in data.docs) {
        final singleProduct = ProductModel.fromJson(product.data());
        singleProduct.productId = product.id;
        productList.add(singleProduct);
      }
    } catch (e) {
      throw Exception(e);
    }
    return productList;
  }

  Future<ProductModel?> fetchSingleProduct(String productId) async {
    try {
      final data = await _fireStore
          .collection('products')
          .doc(productId)
          .get();
      if(data.data() != null){
        final product = ProductModel.fromJson(data.data()!);
        return product;
      }else{
        return null;
      }

    } catch (e) {
      throw Exception(e);
    }
  }
}
