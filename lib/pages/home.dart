import 'package:criando_gerenciamento_estado/classes/counter_state.dart';
import 'package:criando_gerenciamento_estado/controllers/state_observable.dart';
import 'package:criando_gerenciamento_estado/mixins/change_state_mixin.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with ChangeStateMixin {
  final counterState = CounterState();
  final observableCounter = StateObservable(0);
  late StateObservable<int> newMixinObservable;

  @override
  void initState() {
    useChangeState(counterState);
    useChangeState(observableCounter);
    newMixinObservable = useChangeStateObservable(0);
    super.initState();
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
            Text(
              'Valor do Counter State: ${counterState.counter}',
            ),
            ElevatedButton(
              onPressed: () {
                counterState.increment();
              },
              child: Text('Incrementar'),
            ),
            Text(
              'Valor do Observable Counter: ${observableCounter.state}',
            ),
            ElevatedButton(
              onPressed: () {
                observableCounter.state++;
              },
              child: Text('Incrementar'),
            ),
            Text(
              'Valor do New Mixin: ${newMixinObservable.state}',
            ),
            ElevatedButton(
              onPressed: () {
                newMixinObservable.state++;
              },
              child: Text('Incrementar'),
            ),
          ],
        ),
      ),
    );
  }
}
