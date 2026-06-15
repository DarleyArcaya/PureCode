import 'package:flutter/material.dart';
import 'homepage.dart';

class OptimizeWindow extends StatefulWidget {
  const OptimizeWindow({super.key});

  @override
  State<OptimizeWindow> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OptimizeWindow> {
  @override
  Widget build(BuildContext context) {
    int index = 1;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('PureCode'),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 234, 235, 238),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color(0xFF0F172A),
        iconTheme: IconThemeData(color: Colors.white)
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
                  MaterialPageRoute(builder: (context) => const Homepage()),
                );
              }
            },
            indicatorColor: Colors.white,
             unselectedIconTheme: IconThemeData(color: Colors.white),
            selectedIconTheme: const IconThemeData(color: Colors.blue),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home), 
                label: Text('Home', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bolt), 
                label: Text('Optimize Pc', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}