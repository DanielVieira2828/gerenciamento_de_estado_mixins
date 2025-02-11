import 'package:criando_gerenciamento_estado/controllers/change_state.dart';
import 'package:criando_gerenciamento_estado/controllers/state_observable.dart';
import 'package:flutter/material.dart';

mixin ChangeStateMixin<T extends StatefulWidget> on State<T> {
  final List<ChangeState> _changeState = [];

  void useChangeState(ChangeState changeState) {
    changeState.addListener(_callback);
    _changeState.add(changeState);
  }

  StateObservable<T> useChangeStateObservable<T>(T state) {
    final StateObservable<T> stateObservable = StateObservable<T>(state);
    stateObservable.addListener(_callback);
    _changeState.add(stateObservable);
    return stateObservable;
  }

  void _callback() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    for (var changeState in _changeState) {
      changeState.removeListener(_callback);
    }
    super.dispose();
  }
}
