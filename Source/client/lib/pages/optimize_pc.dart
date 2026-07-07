import 'package:flutter/material.dart';
import 'package:purecode/pages/install_github_package.dart';
import 'package:purecode/services/api_services.dart';
import 'homepage.dart';

class OptimizeWindow extends StatefulWidget {
  const OptimizeWindow({super.key});

  @override
  State<OptimizeWindow> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OptimizeWindow> {
  int index = 1;
  
  // Variable que controla la barra de carga superior
  bool _isLoading = false;

  // Esta es la variable local que pintará el texto en la pantalla
  String textLastOptimizationTime = 'Not yet optimized';

  String textgbSaved = '';

  Future<void> optimizePC() async {
    setState(() {
      _isLoading = true;
    });

    debugPrint('Optimizing PC');
   
    // Simulamos que el proceso tarda 3 segundos antes de completarse
    await Future.delayed(const Duration(seconds: 3));
    debugPrint('Optimization Completed');
    
    setState(() {
      _isLoading = false; 
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Optimization Completed!'),
          backgroundColor: Colors.blue, 
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
        automaticallyImplyLeading: false, 
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 234, 235, 238),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color(0xFF0F172A),
        iconTheme: const IconThemeData(color: Colors.white)
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
              if (index == 2) {
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => const InstallGitPackaged()),
                );
              }
            },
            indicatorColor: Colors.white,
            unselectedIconTheme: const IconThemeData(color: Colors.white),
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
                label: Text("Install GitHub\nPackaged", style: TextStyle(fontSize: 16, color: Colors.white))
              )
            ],
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.all(20.0),
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
                          borderRadius: BorderRadius.circular(10.0)
                        )
                      ),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Optimization Process', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                              content: Text('You may save: ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();

                                  
                                  },
                                  child: const Text('Cancel', style: TextStyle(color: Colors.redAccent))
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white
                                  ),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    await optimizePC();
                                    await ApiServices.optimizeSystem();
                                  },
                                  child: const Text('Optimize')
                                )
                              ],
                            );
                          }
                        );

                        String gbSavedRequest = await ApiServices.getGbSavedOptimization();
                        setState(() {
                          textgbSaved = gbSavedRequest;
                        });



                        String pythonRequest = await ApiServices.lastOptimization();
                        setState(() {
                          textLastOptimizationTime = pythonRequest;
                        });
                        
                      },
                      child: const Text('Optimize', style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 200,
                    width: 400,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).cardColor
                    ),
                    // Lee directamente la variable local controlada por el setState de arriba
                    child: Text(
                      ' $textLastOptimizationTime', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ), 
                  ),
                ),
                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 200,
                    width: 400,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).cardColor
                    ),
                    child: Text(
                     'You have saved: $textgbSaved',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
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