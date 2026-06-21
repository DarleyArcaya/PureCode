import 'package:flutter/material.dart';
import 'package:purecode/pages/optimize_pc.dart';
import 'homepage.dart';
class InstallGitPackaged extends StatefulWidget {
  const InstallGitPackaged({super.key});

  @override
  State<InstallGitPackaged> createState() => _InstallGitPackagedState();
}

class _InstallGitPackagedState extends State<InstallGitPackaged> {
  int index = 2;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('PureCode'),
        automaticallyImplyLeading: false, // false to hide the leading icon / No muestra el icon
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
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => const Homepage()),
                );
              }
              if (index == 1) {
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => const OptimizeWindow()),
                );
              }
              if (index == 2) {
                // This is installGithubPackaged
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
              NavigationRailDestination(
                icon: Icon(Icons.download_rounded),
                label: Text("Install GitHub" "\n" "Packaged", style: TextStyle(fontSize: 16, color: Colors.white))
              )
            ],
          ),
          Expanded(
            child: Center(
              child: Text("Future Update", style: TextStyle(fontSize: 60, color: Colors.blue, fontWeight: FontWeight.bold)),

            ),
            )
        ],
        
        )
      );

    
  }
}