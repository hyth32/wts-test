import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc_event.dart';
import 'package:wts_test/abstract/bloc/base_bloc_state.dart';
import 'package:wts_test/repositories/product_details/abstract_product_details_repository.dart';
import 'package:wts_test/repositories/product_list/models/product_model.dart';

part 'product_details_event.dart';

part 'product_details_state.dart';

class ProductDetailsBloc
    extends BaseBloc<ProductDetailsEvent, ProductDetailsState, Product> {
  ProductDetailsBloc(this.productDetailsRepository, this.productId)
      : super(ProductDetailsInitial()) {
    on<LoadProductDetails>(_onLoadProductDetails);
  }

  Future<void> _onLoadProductDetails(
      LoadProductDetails event, Emitter<ProductDetailsState> emit) async {
    await loadItems(
      emit: emit,
      loadItemsFunction: () async {
        final productDetails =
            await productDetailsRepository.getProductDetails(productId);
        return [productDetails];
      },
      loadedState: (items, _) => ProductDetailsLoaded(items[0]),
      loadingFailureState: (exception) =>
          ProductDetailsLoadingFailure(exception: exception),
    );
    event.completer?.complete();
  }

  final AbstractProductDetailsRepository productDetailsRepository;
  final int productId;
}
