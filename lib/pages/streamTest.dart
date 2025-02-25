import 'package:criando_gerenciamento_estado/builders/stream_notifier_builder.dart';
import 'package:criando_gerenciamento_estado/controllers/stream_notifier_imp.dart';
import 'package:flutter/material.dart';

class StreamTest extends StatefulWidget {
  const StreamTest({super.key});

  @override
  State<StreamTest> createState() => _StreamTestState();
}

class _StreamTestState extends State<StreamTest> {
  final _counterNotifier = StreamNotifier(0);

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Testando Streams"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamNotifierBuilder(
              listen: (context, state) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Valor emitido: $state"),
                  ),
                );
              },
              streamNotifier: _counterNotifier,
              builder: (context, state) {
                return Text("Valor do counter: ${_counterNotifier.state}");
              },
            ),
            ElevatedButton(
              onPressed: () {
                _counterNotifier.emit(_counterNotifier.state + 1);
              },
              child: const Text("Incrementar"),
            )
          ],
        ),
      ),
    );
  }
}
