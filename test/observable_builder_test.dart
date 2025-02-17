import 'package:criando_gerenciamento_estado/builders/observable_builder.dart';
import 'package:criando_gerenciamento_estado/controllers/change_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Should test observable builder", () {
    testWidgets("Should test increment Widget", (widgetTests) async {
      await widgetTests.pumpWidget(
        const MaterialApp(
          home: _CounterWidget(),
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

class _CounterWidget extends StatefulWidget {
  const _CounterWidget();

  @override
  State<_CounterWidget> createState() => __CounterWidgetState();
}

class __CounterWidgetState extends State<_CounterWidget> {
  final _counter = _ObservableCounter();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ObservableBuilder(
            observable: _counter,
            builder: (context, child) {
              return Text("Valor do Counter: ${_counter.counter}");
            }),
        ElevatedButton(
            key: const Key(buttonKey),
            onPressed: () {
              _counter.increment();
            },
            child: const Text("Incrementar")),
      ],
    );
  }
}

class _ObservableCounter extends ChangeState {
  int counter = 0;

  void increment() {
    counter++;
    notifyCallbacks();
  }
}
