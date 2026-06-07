import 'package:flutter/material.dart'; 
import 'package:purecode/homepage.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io'; // Importa la biblioteca para manejar procesos y archivos y obtener la ruta actual del directorio para usar la funcion del backend
                  // en la carpeta assets/backend/main.exe, sin esto no podríamos ejecutar el backend desde el cliente, 
                  //ya que no tendríamos acceso a la ruta del archivo main.exe
                  // todo esto incluye lo de Process ?, await runBackend(), y todo lo que esta dentro de Future<void> runBackend() async { ... }
 
Process? backendProcess; // Variable global para almacenar el proceso del backend

void main() async {  // 'async' allows us to use 'await' inside this function
  // HOW I SET UP THE WINDOW MANAGER PLUGIN?

  // STEP 1: Initialize Flutter before using plugins
  // Required when using native plugins before runApp()
  WidgetsFlutterBinding.ensureInitialized();
  
  // STEP 2: Initialize the window manager
  // Prepares window_manager to control the window
  await windowManager.ensureInitialized();

  await runBackend(); // Start the backend process before showing the window

  // STEP 3: Configure window properties
  WindowOptions windowOptions = WindowOptions(
    // Initial window size (width x height in pixels)
    size: const Size(800, 800),
    
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

    // Control windows size limits 
    maximumSize: const Size(800, 800),
    minimumSize: const Size(800, 800),

    
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

// Function to start the backend process
Future <void> runBackend() async {
  try {
    // Get the path to the main.exe file
    String backendPath = '${Directory.current.path}/data/flutter_assets/assets/backend/main.exe';

    // Check if the file exists at the expected location, if not, try the alternative path
    if (!await File(backendPath).exists()) {
      backendPath = '${Directory.current.path}/assets/backend/main.exe';

    }
    // We use DebugPrint instead of print to avoid issues with stdout buffering in Flutter
    // But thy are essentially the same for debugging purposes (Print and DebugPrint)
    debugPrint('Running backend from: $backendPath');

    backendProcess = await Process.start(backendPath, []);
    debugPrint('Backend process started');
  } catch (e) {
    debugPrint('Error occurred while starting backend: $e');
  }
}



class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        checkboxTheme: CheckboxThemeData( // Customize the appearance of checkboxes
          fillColor: WidgetStateProperty.all(Colors.blue) // Set the color of the checkbox when it is checked
        )

      ),
      debugShowCheckedModeBanner: false,
      home: Homepage(
      ),
    );
  }
}
