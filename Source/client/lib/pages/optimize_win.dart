import 'package:flutter/material.dart';

class OptimizeWindow extends StatefulWidget {
  const OptimizeWindow({super.key});

  @override
  State<OptimizeWindow> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OptimizeWindow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Optimize your Window")
      )
    );
  }
}