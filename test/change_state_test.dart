import 'package:criando_gerenciamento_estado/controllers/change_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Should test ChangeState", () {
    test("Should state change", () {
      // Arrange
      final _CounterChangeState changeState = _CounterChangeState();

      // Act
      changeState.increment();

      //Assert
      expect(changeState.counter, 1);
    });

    test("Should execute callback", () {
      // Arrange
      bool callbackChanged = false;
      final _CounterChangeState changeState = _CounterChangeState();

      // Act
      changeState.addListener(() {
        callbackChanged = true;
      });

      changeState.increment();

      //Assert
      expect(callbackChanged, true);
    });
  });
}

class _CounterChangeState extends ChangeState {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyCallbacks();
  }
}
