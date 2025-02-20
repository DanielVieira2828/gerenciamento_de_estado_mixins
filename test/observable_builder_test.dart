import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'testable/widgets/counter_widget.dart';

void main() {
  group("Should test observable builder", () {
    testWidgets("Should test increment Widget", (widgetTests) async {
      await widgetTests.pumpWidget(
        const MaterialApp(
          home: CounterWidget(),
        ),
      );
      final text = find.text("Valor do Counter: 0");

      final button = find.byKey(const Key(buttonKey));

      expect(text, findsOneWidget);

      expect(button, findsOneWidget);

      await widgetTests.tap(button);
      await widgetTests.pump();

      final nextCounter = find.text("Valor do Counter: 1");

      expect(nextCounter, findsOneWidget);
    });
  });
}

const buttonKey = 'incrementButton';
