import 'package:flutter/material.dart';
import 'api_services.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  // State variables to track which caches are selected for cleaning
  bool gradleCaches = false;
  bool androidCaches = false;
  bool flutterCaches = false;
  bool pipCaches = false;
  bool macCaches = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('PureCode'),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 234, 235, 238),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: const Color(0xFF0F172A),
      ),
      body: Center(
        
        child: Column(

          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                height: 100,
                width: 800,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color.fromARGB(255, 233, 233, 233),
              
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Your Mac System Data Caches have been cleaned!"),
                          backgroundColor: Colors.blue
                          )
                          
                        

                        );
                      },
                  child: Image.asset('assets/cleanpc/mac.png', height: 100, width: 100, fit: BoxFit.contain),
                ),
                  
                  ]
                )
                 
              ),

              
              ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                width: 800,
                height: 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color.fromARGB(255, 233, 233, 233),
                  ),
                  child: ListView(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      SizedBox(height: 20),
                      

                      CheckboxListTile( // This widget provides a checkbox with a title and subtitle, making it ideal for our cache cleaning options
                        title: Text('Gradle Caches'),
                        subtitle: Text('Removes .gradle build artifacts'),
                        value: gradleCaches,
                        onChanged: (bool? value) {
                          setState(() {
                            gradleCaches = value ?? false;
                          });
                        }
                      ),

                      SizedBox(height: 20),

                      CheckboxListTile(
                        title: Text('Android Studio Caches'),
                        subtitle: Text('Removes Android Studio Caches files'),
                        value: androidCaches,
                        onChanged: (bool? value) {
                          setState(() {
                            androidCaches = value ?? false;
                          });
                        }
                      ),

                      SizedBox(height: 20),

                      CheckboxListTile(
                        title: Text('Flutter Caches'),
                        subtitle: Text('Removes Flutter Caches files'),
                        value: flutterCaches,
                        onChanged: (bool? value) {
                          setState(() {
                            flutterCaches = value ?? false;
                          });
                        }
                      ),

                      SizedBox(height: 20),

                      CheckboxListTile(
                        title: Text('Pip Python Caches'),
                        subtitle: Text('Removes Pip Python Caches files'),
                        value: pipCaches,
                        onChanged: (bool? value) {
                          setState(() {
                            pipCaches = value ?? false;
                          });
                        }
                      )

                      ],
                  ),
                  ),
                ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFE2E8F0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Text('Copyright © 2026 by Darley Silot Arcaya'),
              Spacer(),
              ElevatedButton(
                onPressed: () async { 
                  
                  if (!gradleCaches && !androidCaches && !flutterCaches && !pipCaches) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select at least one cache to clean.'),
                        backgroundColor: Colors.orange,
                      )
                    );
                    return;
                  }

                  bool success = true;
                  
                  if (gradleCaches) {
                    await ApiServices.removeGradleCaches();
                    if (!gradleCaches) success = false;
                  }
                  if (androidCaches) {
                    await ApiServices.removeAndroidCaches();
                    if (!androidCaches) success = false;
                  }
                  if (flutterCaches) {
                    await ApiServices.removeFlutterCaches();
                    if (!flutterCaches) success = false;
                  }
                  if (pipCaches) {
                    await ApiServices.removePipPythonCaches();
                    if (!pipCaches) success = false;
                  }

                  // Avoid the "async gaps" error by ensuring the screen remains active
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(success
                      ? 'Selected caches cleaned successfully!'
                      : 'An error ocurred while cleaning caches. Please try again.'),
                      backgroundColor: success ? Colors.blue : Colors.red,
                    )
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white
                ), 
                child: const Text('Clean'),
              )
            ],
          )
        ),
        
      )
    );
  } 
}