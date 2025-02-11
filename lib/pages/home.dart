import 'package:criando_gerenciamento_estado/builders/observable_builder.dart';
import 'package:criando_gerenciamento_estado/builders/observable_state_builder.dart';
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
            ObservableStateBuilder(
                listener: (context, state) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Valor do Counter State: $state'),
                    ),
                  );
                },
                buildWhen: (oldstate, newstate) {
                  return newstate % 2 == 0;
                },
                stateObservable: observableCounter,
                builder: (context, state, child) {
                  return Text(
                    'Valor do Counter State: $state',
                  );
                }),
            ElevatedButton(
              onPressed: () {
                observableCounter.state++;
              },
              child: Text('Incrementar'),
            ),
          ],
        ),
      ),
    );
  }
}
