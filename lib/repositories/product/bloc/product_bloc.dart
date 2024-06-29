import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wts_test/repositories/category/category.dart';
import 'package:wts_test/repositories/product/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc(this.productRepository, this.category) : super(ProductInitial()) {
    on<LoadProductList>((event, emit) async {
      final productList = await productRepository.getProductsList(categoryId: category?.categoryId);
      emit(ProductStateLoaded(productList: productList));
    });
  }

  final Category? category;
  final AbstractProductRepository productRepository;
}