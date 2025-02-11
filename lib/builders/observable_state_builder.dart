import 'package:criando_gerenciamento_estado/controllers/state_observable.dart';
import 'package:flutter/material.dart';

class ObservableStateBuilder<T> extends StatefulWidget {
  const ObservableStateBuilder({
    super.key,
    required this.stateObservable,
    required this.builder,
    this.child,
    this.buildWhen,
    this.listener,
  });

  final StateObservable<T> stateObservable;
  final Widget Function(BuildContext context, T state, Widget? child) builder;
  final bool Function(T oldstate, T newstate)? buildWhen;
  final void Function(BuildContext context, T state)? listener;
  final Widget? child;

  @override
  State<ObservableStateBuilder<T>> createState() =>
      _ObservableStateBuilderState<T>();
}

class _ObservableStateBuilderState<T> extends State<ObservableStateBuilder<T>> {
  late T state;
  @override
  void initState() {
    widget.stateObservable.addListener(callback);
    state = widget.stateObservable.state;
    super.initState();
  }

  void callback() {
    if (shouldRebuild()) {
      state = widget.stateObservable.state;
      if (widget.listener != null) {
        widget.listener!(context, state);
      }
      setState(() {});
    } else {
      state = widget.stateObservable.state;
    }
  }

  bool shouldRebuild() {
    if (widget.buildWhen == null) {
      return true;
    }
    return widget.buildWhen!(state, widget.stateObservable.state);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      state,
      widget.child,
    );
  }

  @override
  void dispose() {
    widget.stateObservable.removeListener(() {
      setState(() {});
    });
    super.dispose();
  }
}
