import 'dart:async';

import 'package:criando_gerenciamento_estado/controllers/stream_notifier_imp.dart';
import 'package:flutter/material.dart';

class StreamTest extends StatefulWidget {
  const StreamTest({super.key});

  @override
  State<StreamTest> createState() => _StreamTestState();
}

class _StreamTestState extends State<StreamTest> {
  final _counterNotifier = StreamNotifier(0);

  late StreamSubscription<int>? _streamSubscription;

  @override
  void initState() {
    _streamSubscription = _counterNotifier.stream.listen((newState) {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Testando Streams"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Valor do counter: ${_counterNotifier.state}"),
            ElevatedButton(
              onPressed: () {
                _counterNotifier.emit(_counterNotifier.state);
              },
              child: Text("Incrementar"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
    super.dispose();
  }
}
