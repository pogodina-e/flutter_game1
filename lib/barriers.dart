// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {

  final size;

  const MyBarrier({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(width: 10,
        color: const Color(0xFF2E7D32)),
        borderRadius: BorderRadius.circular(15)
      ),
    );
  }
}
