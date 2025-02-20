import 'package:criando_gerenciamento_estado/controllers/state_observable.dart';
import 'package:flutter/material.dart';

import '../entities/product_entity.dart';
import '../../state_observable_test.dart';
import '../states/base_state.dart';

@visibleForTesting
class ProductController extends StateObservable<BaseState> {
  ProductController() : super(InitialState());

  @visibleForTesting
  void fetchProduct() {
    state = LoadingState();

    state = SucessState(data: [
      Product(id: 1, name: "Product 1"),
      Product(id: 2, name: "Product 2")
    ]);
  }

  @visibleForTesting
  void generateError() {
    state = LoadingState();

    try {
      throw Exception("Error");
    } catch (e) {
      state = ErrorState(message: e.toString());
    }
  }
}
