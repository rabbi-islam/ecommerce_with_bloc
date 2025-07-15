import 'package:bloc/bloc.dart';
import 'package:ecommerce_with_bloc/src/data/model/product_model.dart';
import 'package:ecommerce_with_bloc/src/data/repository/product_repository.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository productRepository;
  ProductBloc(this.productRepository) : super(ProductInitial()) {

    on<FetchProduct>((event, emit) async {
      try{
        final products = await productRepository.fetchProducts();
        emit(ProductFetchSuccess(products));
      }catch(e){
        emit(ProductFetchFailed("Product Fetch Failed: ${e.toString()}"));
      }
    });

    on<FetchSingleProduct>((event, emit) async {
      try{
        final product = await productRepository.fetchSingleProduct(event.productId);
        if(product != null){
          emit(SingleProductFetchSuccess(product));
        }else{
          emit(ProductFetchFailed("Product Fetch Failed"));
        }
      }catch(e){
        emit(ProductFetchFailed("Product Fetch Failed: ${e.toString()}"));
      }
    });
  }
}
