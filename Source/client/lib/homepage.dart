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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                height: 100,
                width: 800,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xFFFFFFFF),
              
                ),
                child: Text('Here, you will read what the program does'),
                
              ),

              
              ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                width: 800,
                height: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xFFFFFFFF),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('What caches will be automaticly cleaned',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      )
                      ),
                      
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
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFE2E8F0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: const Center(
            child: Text('Made by Darley Silot Arcaya'),
          ),
        )
      )
    );
  } 
}