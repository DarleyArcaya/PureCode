import 'package:flutter/material.dart'; 
import 'package:purecode/homepage.dart';
import 'package:window_manager/window_manager.dart';

void main() async {  // 'async' allows us to use 'await' inside this function
  // HOW I SET UP THE WINDOW MANAGER PLUGIN?

  // STEP 1: Initialize Flutter before using plugins
  // Required when using native plugins before runApp()
  WidgetsFlutterBinding.ensureInitialized();
  
  // STEP 2: Initialize the window manager
  // Prepares window_manager to control the window
  await windowManager.ensureInitialized();

  // STEP 3: Configure window properties
  WindowOptions windowOptions = WindowOptions(
    // Initial window size (width x height in pixels)
    size: const Size(900, 900),
    
    // Centers the window on screen when opening
    center: true,
    
    // Window background color (transparent = no color)
    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
    
    // false = app appears in Windows taskbar
    skipTaskbar: false,
    
    // Title bar style (normal = standard Windows bar)
    titleBarStyle: TitleBarStyle.normal,
    
    // Window Title (appears in title bar and taskbar)
    title: 'PureCode',

    minimumSize: const Size(900, 900),
    // OTHER OPTIONS YOU CAN ADD:
    // minimumSize: const Size(400, 300),  // Minimum size (can't make smaller)
    // maximumSize: const Size(1920, 1080), // Maximum size (can't make bigger)
    // alwaysOnTop: true,  // Window always visible on top of others
    // fullScreen: true,   // Open in fullscreen mode
  );

  // STEP 4: Apply configuration to the window
  // Waits for window to be ready, then shows and focuses it
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();   // Makes the window visible
    await windowManager.focus();  // Puts focus on the window
  });

  // STEP 5: Start the Flutter application
  // Must go AFTER setting up the window, not before
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override

  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(
      ),
    );
  }
}
