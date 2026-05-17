import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                height: 100,
                width: 800,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[200],
              
                ),
                child: Text('Here, you will read what the program does'),
                
              ),

              
              ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                width: 800,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[200],
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('What caches will be automaticly cleaned'),
                      SizedBox(height: 30),
                      
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'flutter caches'
                        ),
                      ),

                      SizedBox(height: 30),

                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Android Caches'
                        ),
                      ),

                      SizedBox(height: 30),

                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Gradle Caches'
                        ),  
                      ),

                      SizedBox(height: 30),

                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'PIP Caches'
                        ),
                      )

                      ],
                  ),
                  ),
                ),
          ],
        ),
      ),
    );
  } 
}