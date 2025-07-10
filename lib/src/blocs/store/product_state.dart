part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductFetchSuccess extends ProductState {
  final List<ProductModel> productList;

  const ProductFetchSuccess(this.productList);

  @override
  List<Object?> get props => [productList];
}

final class ProductFetchFailed extends ProductState {
  final String message;

  const ProductFetchFailed(this.message);

  @override
  List<Object?> get props => [message];
}



