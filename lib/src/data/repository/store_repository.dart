import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_with_bloc/src/data/dummy/dummy_brands.dart';
import 'package:ecommerce_with_bloc/src/data/dummy/dummy_products.dart';
import 'package:ecommerce_with_bloc/src/data/model/brand_model.dart';
import 'package:flutter/foundation.dart';

class StoreRepository{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createNewBrand()async {

    try{
      for(var brand in dummyBrands){
        await _firestore.collection('brands').add(brand.toJson());
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }

  Future<void> createNewProduct()async {

    try{
      for(var product in dummyProducts){
        await _firestore.collection('products').add(product.toJson());
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }

  Future<List<BrandModel>> fetchBrands() async {
    final List<BrandModel> brandList = [];
    final brandSnapshot = await _firestore.collection('brands').get();

    try{
      for(var brand in brandSnapshot.docs){
        brandList.add(BrandModel.fromJson(brand.data()));
        debugPrint("Brands name: ${brand.data()}");
      }
    }catch(e){
      throw Exception(e);
    }
    return brandList;

  }
}