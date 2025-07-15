import 'package:bloc/bloc.dart';
import 'package:ecommerce_with_bloc/src/data/model/category_model.dart';
import 'package:ecommerce_with_bloc/src/data/repository/repository.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  StoreRepository storeRepository;
  CategoryBloc(this.storeRepository) : super(CategoryInitial()) {

    on<FetchSingleCategory>((event, emit) async {
      try{
        final category = await storeRepository.fetchSingleCategory(event.categoryId);
        if(category != null){
          emit(CategoryFetchSuccess(category));
        }else{
          emit(CategoryFetchFailed("Category is empty!"));
        }
      }catch(e){
        emit(CategoryFetchFailed("Unable to get category"));
      }
    });

  }
}
