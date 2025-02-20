import 'package:criando_gerenciamento_estado/controllers/change_state.dart';
import 'package:flutter/material.dart';

@visibleForTesting
class ObservableCounter extends ChangeState {
  int counter = 0;
  @visibleForTesting
  void increment() {
    counter++;
    notifyCallbacks();
  }
}
