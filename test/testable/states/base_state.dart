import 'package:flutter/material.dart';

@visibleForTesting
abstract class BaseState {}

class InitialState extends BaseState {}

class LoadingState extends BaseState {}

class SucessState<T extends Object> extends BaseState {
  final T data;

  SucessState({required this.data});
}
