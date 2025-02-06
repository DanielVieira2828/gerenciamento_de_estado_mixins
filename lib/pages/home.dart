import 'package:criando_gerenciamento_estado/classes/counter_state.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counterState = CounterState();
  @override
  void initState() {
    counterState.addListener(callback);
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
            Text(
              'Valor do estado: ${counterState.counter}',
            ),
            ElevatedButton(
                onPressed: () {
                  counterState.increment();
                },
                child: Text("Incrementar"))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    counterState.removeListener(callback);
    super.dispose();
  }
}
