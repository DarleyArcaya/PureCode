import 'package:flutter/material.dart';
import 'package:purecode/pages/installGithubPackaged.dart';
import 'homepage.dart';

class OptimizeWindow extends StatefulWidget {
  const OptimizeWindow({super.key});

  @override
  State<OptimizeWindow> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OptimizeWindow> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('PureCode'),
        automaticallyImplyLeading: false, // false to hide the leading icon / No muestra el icono para virar en las paginas

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
                // This is optimize pc
              }
              
              if (index == 2) {
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => const InstallGitPackaged()),
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
              NavigationRailDestination(
                icon: Icon(Icons.download_rounded),
                label: Text("Install GitHub" "\n" "Packaged", style: TextStyle(fontSize: 16, color: Colors.white))
              )
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 100,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).cardColor
                    ),
                    child: Text("You will be able to optimize your system just with one click."  "\nWorking: Windows and MacOS.",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )
                  )

                ),

                SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 200,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).cardColor
                    ),
                    child: Text('Here will appear if the machine is optimized or need to be optimized.')
                  )
                )
                
              ],
            )
          ),

          
          
        ],
        
      ),
    );
  }
}