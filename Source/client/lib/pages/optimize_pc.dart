import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:purecode/pages/homepage.dart';
=======
import 'homepage.dart';
>>>>>>> 0ce3ec6d8906d70e5ccded8c26234b6f60e74138


class OptimizeWindow extends StatefulWidget {
  const OptimizeWindow({super.key});

  @override
  State<OptimizeWindow> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OptimizeWindow> {
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    int _index = 1;

=======
    int index = 1;
    
>>>>>>> 0ce3ec6d8906d70e5ccded8c26234b6f60e74138
    return Scaffold(
      appBar: AppBar(
        title: const Text('PureCode'),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 234, 235, 238),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color(0xFF0F172A),
      ),
      body: Row(
        children: [
          NavigationRail(
            labelType: NavigationRailLabelType.all,
            backgroundColor: const Color(0xFF0F172A),
            selectedIndex: index,

            onDestinationSelected: (int index) {
              if (index == 0) {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => Homepage())
                  );
              }
              
            },
            indicatorColor: Colors.white,
            selectedIconTheme: IconThemeData(color: Colors.blue),

            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bolt),
                label: Text('Optimize Pc', style: TextStyle(fontSize: 16, color: Colors.white))
              )
            ],
          ),
        ]
      )
    );
  }
}