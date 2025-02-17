import 'package:criando_gerenciamento_estado/controllers/state_observable.dart';
import 'package:flutter_test/flutter_test.dart';

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
            isInstanceOf<State<List<Product>>>(),
          ],
        ),
      );
      productController.fetchProduct();
    });
  });
}

abstract class BaseState {}

class InitialState extends BaseState {}

class LoadingState extends BaseState {}

class SucessState<T extends Object> extends BaseState {
  final T data;

  SucessState({required this.data});
}

class ErrorState extends BaseState {
  final String message;

  ErrorState({required this.message});
}

class Product {
  final int id;
  final String name;

  Product({
    required this.id,
    required this.name,
  });
}

class ProductController extends StateObservable<BaseState> {
  ProductController() : super(InitialState());

  void fetchProduct() {
    state = LoadingState();

    state = SucessState(data: [
      Product(id: 1, name: "Product 1"),
      Product(id: 2, name: "Product 2")
    ]);
  }

  void generateError() {
    state = ErrorState(message: "Error");
  }
}
