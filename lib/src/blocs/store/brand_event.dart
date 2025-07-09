part of 'brand_bloc.dart';

@immutable
sealed class BrandEvent extends Equatable {

  @override
  List<Object?> get props => [];
}

class FetchBrands extends BrandEvent{}
