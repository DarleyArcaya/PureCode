import 'dart:ui';
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
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF0F172A)
              ),
              child: 
              Text("Menu",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30
              )
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('About PureCode', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),

                      content: Text("PureCode is a tool designed to optimize the workflow of developers and advanced users by simplifying system maintenance. With a single click, it allows you to debug workstations by deleting unnecessary temporary files and caches. Its most notable feature is the ability to manage and reduce 'System Data' files on macOS, freeing up storage space quickly and safely."
                      , style: TextStyle(fontSize: 20, color: Color(0xFF0F172A))),
                    );
                  }
                );

              },
              
            )
          
          ],
        ),
      ),
      body: Center(
        
        child: Column(

          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                height: 100,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color.fromARGB(255, 233, 233, 233),
              
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Your Mac System Data Caches have been cleaned!"),
                          backgroundColor: Colors.blue
                          )
                          
                        

                        );
                      },
                  child: Container(
                    padding: const EdgeInsets.all(10), // Padding para darle margen interno // Padding for internal margin
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Importante para que el ripple se vea bien // Important for the ripple effect to look good
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 5)],
                  ),

                  child: Image.asset(
                  'assets/cleanpc/mac.png', 
                  height: 100, 
                  width: 100, 
                  fit: BoxFit.contain
                  ),

                ),
                    )
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
                      

                      CheckboxListTile( 
                        // This widget provides a checkbox with a title and subtitle, making it ideal for our cache cleaning options
                        title: Text('Gradle Caches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), // Title of the checkbox
                        subtitle: Text('Removes .gradle build artifacts', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blue)), // Subtitle providing more information about what this option does
                        value: gradleCaches,
                        onChanged: (bool? value) {
                          setState(() {
                            gradleCaches = value ?? false;
                          });
                        }
                      ),

                      SizedBox(height: 20),



                      CheckboxListTile(
                        title: Text('Android Studio Caches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        subtitle: Text('Removes Android Studio Caches files', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blue)),
                        value: androidCaches,
                        onChanged: (bool? value) {
                          setState(() {
                            androidCaches = value ?? false;
                          });
                        }
                      ),

                      SizedBox(height: 20),

                      CheckboxListTile(
                        title: Text('Flutter Caches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        subtitle: Text('Removes Flutter Caches files', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blue)),
                        value: flutterCaches,
                        onChanged: (bool? value) {
                          setState(() {
                            flutterCaches = value ?? false;
                          });
                        }
                      ),

                      SizedBox(height: 20),

                      CheckboxListTile(
                        title: Text('Pip Python Caches', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        subtitle: Text('Removes Pip Python Caches files', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.blue)),
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