import 'package:criando_gerenciamento_estado/controllers/state_observable.dart';
import 'package:criando_gerenciamento_estado/extensions/state_observable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'testable/controllers/product_controller.dart';
import 'testable/entities/product_entity.dart';
import 'testable/states/base_state.dart';

void main() {
  group("Should test State Observable", () {
    test(
      "Should update state correctly when we increment counter",
      () {
        //arrange
        final counterState = StateObservable(0);

        //act

        counterState.state++;

        //assert

        expect(counterState.state, 1);
      },
    );

    test(
      "Should execute StateObservable callback when we increment counter",
      () {
        //arrange
        final counterState = StateObservable(0);
        bool callbackExecuted = false;

        //act

        void callback() {
          callbackExecuted = true;
        }

        counterState.addListener(callback);

        counterState.state++;

        //assert

        expect(counterState.state, 1);

        expect(callbackExecuted, true);
      },
    );

    test("Should generate SucessState when we call (getProducts)", () {
      //arrange
      final ProductController productController = ProductController();

      expect(productController.state, isA<InitialState>());

      //act
      productController.fetchProduct();

      //assert
      expect(productController.state, isA<SucessState>());
    });

    test("Should generate states in sequence", () {
      final ProductController productController = ProductController();

      expect(
        productController.asStream(),
        emitsInOrder(
          [
            isInstanceOf<InitialState>(),
            isInstanceOf<LoadingState>(),
            isInstanceOf<SucessState<List<Product>>>(),
          ],
        ),
      );
      productController.fetchProduct();
    });

    test("Should generate states in sequence when we get error", () {
      final ProductController productController = ProductController();

      expect(
        productController.asStream(),
        emitsInOrder(
          [
            isInstanceOf<InitialState>(),
            isInstanceOf<LoadingState>(),
            isInstanceOf<ErrorState>(),
          ],
        ),
      );
      productController.generateError();
    });

    test(
        "Should generate states in sequence when we get error after getting sucess",
        () {
      final ProductController productController = ProductController();

      expect(
        productController.asStream(),
        emitsInOrder(
          [
            isInstanceOf<InitialState>(),
            isInstanceOf<LoadingState>(),
            isInstanceOf<SucessState<List<Product>>>(),
            isInstanceOf<LoadingState>(),
            isInstanceOf<ErrorState>(),
          ],
        ),
      );

      productController.fetchProduct();

      productController.generateError();
    });

    test("Testing value notifier", () {
      final valueNotifier = ValueNotifier(0);

      expect(valueNotifier.asStream(), emitsInOrder([0, 1, 2]));

      valueNotifier.value++;
      valueNotifier.value++;
    });
  });
}

class ErrorState extends BaseState {
  final String message;

  ErrorState({required this.message});
}
