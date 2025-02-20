import 'dart:async';

import 'package:criando_gerenciamento_estado/controllers/state_observable.dart';
import 'package:flutter/material.dart';

@visibleForTesting
extension ObservableStream<T> on StateObservable<T> {
  @visibleForTesting
  Stream<T> asStream() {
    StreamController<T> streamController = StreamController<T>();

    streamController.add(state); //Initial state

    void callback() {
      streamController.add(state); //Loading -> Success
    }

    addListener(callback);

    return streamController.stream;
  }
}

@visibleForTesting
extension ObservableStateNotifier<T> on ValueNotifier<T> {
  @visibleForTesting
  Stream<T> asStream() {
    StreamController<T> streamController = StreamController<T>();

    streamController.add(value); //Initial state

    void callback() {
      streamController.add(value); //Loading -> Success
    }

    addListener(callback);

    return streamController.stream;
  }
}
