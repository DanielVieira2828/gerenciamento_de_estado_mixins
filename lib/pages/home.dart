import 'package:criando_gerenciamento_estado/builders/observable_builder.dart';
import 'package:criando_gerenciamento_estado/classes/counter_state.dart';
import 'package:criando_gerenciamento_estado/controllers/state_observable.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counterState = CounterState();
  final observableCounter = StateObservable(0);
  @override
  void initState() {
    observableCounter.addListener(callback);
    super.initState();
  }

  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Gerenciamento de Estado"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ObservableBuilder(
              observable: counterState,
              child: const Text("Child Widget"),
              builder: (context, child) {
                return Column(
                  children: [
                    Text(
                      'Valor do estado do ChangeState: ${counterState.counter}',
                    ),
                    child!,
                  ],
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                counterState.increment();
              },
              child: Text("Incrementar"),
            ),
            Text(
              'Valor do estado do ObservableState: ${observableCounter.state}',
            ),
            ElevatedButton(
              onPressed: () {
                observableCounter.state++;
              },
              child: Text("Incrementar"),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    observableCounter.removeListener(callback);
    super.dispose();
  }
}
