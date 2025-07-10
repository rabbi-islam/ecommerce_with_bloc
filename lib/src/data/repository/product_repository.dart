import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_with_bloc/src/data/model/product_model.dart';
import 'package:flutter/foundation.dart';

class ProductRepository{

  final _fireStore = FirebaseFirestore.instance;

  Future<List<ProductModel>> fetchProducts() async {
    final List<ProductModel> productList = [];
    final brandSnapshot = await _fireStore.collection('products').get();

    try{
      for(var product in brandSnapshot.docs){
        productList.add(ProductModel.fromJson(product.data()));
        debugPrint("Product name: ${product.data()}");
      }
    }catch(e){
      throw Exception(e);
    }
    return productList;

  }
}