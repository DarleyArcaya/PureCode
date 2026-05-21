import 'package:flutter/material.dart';
import 'api_services.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
                child: Text('PureCode is an optimization tool designed by a developer, for developers. It focuses on "surgical cleaning" for development environments, removing unnecessary files that generic cleaners usually ignore. Caches removed here are: Gradle Build Caches, Android Studio Cache, PIP Python Caches and Flutter Caches. There will be more caches added in the future. YOU ARE USING THIS APP UNDER YOUR OWN RESPONSABILITY. If you are not a developer, please do not'),
                
              ),

              
              ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                width: 800,
                height: 320,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color.fromARGB(255, 233, 233, 233),
                  ),
                  child: ListView(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('👇 Caches that will be removed are 👇',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      )
                      ),
                      
                      SizedBox(height: 20),
                      
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Flutter Caches: [WIN - LOCALAPPDATA/pub/cache] | [MacOs - ~/.pub-cache]'
                        ),
                      ),

                      SizedBox(height: 20),

                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Android Caches: ~/.android/cache'
                        ),
                      ),

                      SizedBox(height: 20),

                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Gradle Caches: ~/.gradle/caches/'
                        ),  
                      ),

                      SizedBox(height: 20),

                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'PIP Caches: [WIN - LOCALAPPDATA/pip/cache] | [MacOs - ~/Library/Caches/pip]'
                        ),
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
                  // Avoid the "async gaps" error by ensuring the screen remains active                  if (!context.mounted) return;
                  bool result = await ApiServices.runAllCleaners();
                  
                  // Avoid the "async gaps" error by ensuring the screen remains active
                  if (!context.mounted) return;

                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cache cleaned successfully!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cache are already clean or something went wrong.')),
                    );
                  }
                }, 
                child: const Text('Clean'),
              )
            ],
          )
        ),
        
      )
    );
  } 
}