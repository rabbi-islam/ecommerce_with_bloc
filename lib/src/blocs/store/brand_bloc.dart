import 'package:bloc/bloc.dart';
import 'package:ecommerce_with_bloc/src/data/model/brand_model.dart';
import 'package:ecommerce_with_bloc/src/data/repository/store_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {

  StoreRepository repository;
  BrandBloc(this.repository) : super(BrandInitial()) {
    on<FetchBrands>((event, emit) async {
      try{
        final brands = await repository.fetchBrands();
        emit(BrandFetchSuccess(brands));

      }catch(e){
        emit(BrandFetchFailed("Brands Fetch Failed: ${e.toString()}"));
      }
    });
  }
}
