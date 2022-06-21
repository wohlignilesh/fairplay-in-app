import 'package:flutter/material.dart';

abstract class StateView<T1, T2> extends StatelessWidget {
  final T2 state;
  T1 get widget => (state as State).widget as T1;
  const StateView(this.state, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context);
}
