import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc.dart';
import 'package:wts_test/abstract/bloc/base_bloc_event.dart';
import 'package:wts_test/abstract/bloc/base_bloc_state.dart';
import 'package:wts_test/repositories/product_details/abstract_product_details_repository.dart';
import 'package:wts_test/repositories/product_list/models/product_model.dart';

part 'product_details_event.dart';

class ProductDetailsBloc
    extends BaseBloc<ProductDetailsEvent, BlocState, Product> {
  final AbstractProductDetailsRepository productDetailsRepository;
  final int productId;

  ProductDetailsBloc(
    this.productDetailsRepository,
    this.productId,
  ) : super(const InitialState()) {
    on<LoadProductDetails>(_onLoadProductDetails);
  }

  Future<void> _onLoadProductDetails(
    LoadProductDetails event,
    Emitter<BlocState> emit,
  ) async {
    final response = await productDetailsRepository.getProductDetails(
      productId,
    );
    if (response.isError) {
      emit(ErrorState(message: response.error!));
      return;
    }
    emit(DataFoundState(data: response.data));
    event.completer?.complete();
  }
}
