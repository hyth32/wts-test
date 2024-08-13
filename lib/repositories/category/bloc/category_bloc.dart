import 'package:wts_test/abstract/bloc/base_bloc_state.dart';
import 'package:wts_test/abstract/bloc/base_listview_bloc.dart';
import 'package:wts_test/api/entities/api_response.dart';
import 'package:wts_test/repositories/category/abstract_category_repository.dart';
import 'package:wts_test/repositories/category/models/category_model.dart';

class CategoryBloc extends BaseListviewBloc<Category> {
  final AbstractCategoryRepository categoryRepository;

  CategoryBloc(
    this.categoryRepository,
  ) : super(const InitialState());

  @override
  Future<ApiResponse<List<Category>>> fetchData() async {
    return categoryRepository.getCategoriesList();
  }
}
