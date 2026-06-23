import 'package:flutter/material.dart';
import 'package:purecode/pages/installGithubPackaged.dart';
import 'package:purecode/services/api_services.dart';
import 'homepage.dart';


class OptimizeWindow extends StatefulWidget {
  const OptimizeWindow({super.key});

  @override
  State<OptimizeWindow> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OptimizeWindow> {
  int index = 1;

  
  // Variable that will control if we are charging or not
  bool _isLoading = false;

   Future <void> optimizePC() async {
    setState(() {
      _isLoading = true;
    });

    debugPrint('Optimizing PC');
   
 
    // Where wil go the real logic with API
     // Usamos Future.delayed para simular que el proceso tarda 3 segundos.
    await Future.delayed(Duration(seconds: 3));
    debugPrint('Optimization Complated');
    
    setState(() {
      _isLoading = false; // Set the loading state back to fals
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Optimization Completed!'),
        backgroundColor: Colors.blue, // Green color for the snackbar
        behavior: SnackBarBehavior.floating,
        )
      );

    } 
  }

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
              children: <Widget>[
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsetsGeometry.all(20.0),
                    child: LinearProgressIndicator(
                      backgroundColor: Color(0xFF1E293B),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      minHeight: 6,
                    ),
                  ),
                

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 100,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).cardColor
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero
                        )
                      ),
                       onPressed:() async {
                         await optimizePC(); // Call the function to optimize the
                         await ApiServices.optimizeSystem(); // Call the function to optimize the system

                       },
                       child: const Text('Optimize'),
                    ),
                    
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
            ),
            
          ),

          
          
        ],
        
      ),
    );
  }
}