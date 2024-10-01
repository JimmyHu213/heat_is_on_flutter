import 'package:flutter/material.dart';

class CenterView extends StatelessWidget {
  const CenterView({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      child: child,
    );
  }
}
