import 'package:criando_gerenciamento_estado/controllers/change_state.dart';
import 'package:flutter/material.dart';

@visibleForTesting
class CounterChangeState extends ChangeState {
  int _counter = 0;

  int get counter => _counter;
  @visibleForTesting
  void increment() {
    _counter++;
    notifyCallbacks();
  }
}
