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

// int

extension ReactiveInt on int {
  /// Create a [StateObservable] from an [int] value.
  ///
  /// Example: 0.obs();
  ///
  StateObservable<int> obs() {
    return StateObservable<int>(this);
  }
}

// double

extension ReactiveDouble on double {
  /// Create a [StateObservable] from a [double] value.
  ///
  /// Example: 0.0.obs();
  ///
  StateObservable<double> obs() {
    return StateObservable<double>(this);
  }
}

// String

extension ReactiveString on String {
  /// Create a [StateObservable] from an [String] value.
  ///
  /// Example: "Hello".obs();
  ///
  StateObservable<String> obs() {
    return StateObservable<String>(this);
  }
}

// bool

extension ReactiveBool on bool {
  /// Create a [StateObservable] from an [bool] value.
  ///
  /// Example: false.obs();
  ///
  StateObservable<bool> obs() {
    return StateObservable<bool>(this);
  }
}
