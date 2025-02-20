import 'package:flutter_test/flutter_test.dart';

import 'testable/controllers/counter_change_state.dart';

void main() {
  group("Should test ChangeState", () {
    test("Should state change", () {
      // Arrange
      final CounterChangeState changeState = CounterChangeState();

      // Act
      changeState.increment();

      //Assert
      expect(changeState.counter, 1);
    });

    test("Should execute callback", () {
      // Arrange
      bool callbackChanged = false;
      final CounterChangeState changeState = CounterChangeState();

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
