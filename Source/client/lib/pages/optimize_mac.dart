import 'package:flutter/material.dart';

class OptimizeMac extends StatefulWidget {
  const OptimizeMac({super.key});

  @override
  State<OptimizeMac> createState() => _OptimizeMacState();
}

class _OptimizeMacState extends State<OptimizeMac> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Optimize your Mac")
      ),
    );
  }
}