import 'package:criando_gerenciamento_estado/contracts/observable.dart';
import 'package:flutter/material.dart';

class ObservableBuilder extends StatefulWidget {
  const ObservableBuilder({
    super.key,
    required this.observable,
    required this.builder,
    this.child,
  });

  final Observable observable;
  final Widget Function(BuildContext context, Widget? child) builder;
  final Widget? child;

  @override
  State<ObservableBuilder> createState() => _ObservableBuilderState();
}

class _ObservableBuilderState extends State<ObservableBuilder> {
  @override
  void initState() {
    widget.observable.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.child);
  }

  @override
  void dispose() {
    widget.observable.removeListener(() {
      setState(() {});
    });
    super.dispose();
  }
}
