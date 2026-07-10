import 'package:flutter/material.dart';
import 'package:purecode/helpers/theme_controller.dart'; 
import 'package:purecode/pages/homepage.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io'; // Importa la biblioteca para manejar procesos y archivos y obtener la ruta actual del directorio para usar la funcion del backend
                  // en la carpeta assets/backend/main.exe, sin esto no podríamos ejecutar el backend desde el cliente, 
                  //ya que no tendríamos acceso a la ruta del archivo main.exe
                  // todo esto incluye lo de Process ?, await runBackend(), y todo lo que esta dentro de Future<void> runBackend() async { ... }
import 'package:shared_preferences/shared_preferences.dart'; // Esto es para almacenar las preferencias del usuario


Process? backendProcess; // Variable global para almacenar el proceso del backend



void main() async {  // 'async' allows us to use 'await' inside this function
  WidgetsFlutterBinding.ensureInitialized(); // macOs need this here for work....
  // Parte de la logica que usamos para guardar el tema oscuro o blanco en el disco y no en la memoria
  final prefs = await SharedPreferences.getInstance(); // Variable global para almacenar las preferencias del usuario
  bool savedTheme = prefs.getBool('isDarkMode') ?? false; // Variable global para almacenar si el usuario
  isDarkMode.value = savedTheme; // Set the initial theme based on the saved preference

  
  // HOW I SET UP THE WINDOW MANAGER PLUGIN?
  
  // STEP 1: Initialize Flutter before using plugins
  // Required when using native plugins before runApp()
  //////WidgetsFlutterBinding.ensureInitialized();///////
  
  // STEP 2: Initialize the window manager
  // Prepares window_manager to control the window
  await windowManager.ensureInitialized();

  await runBackend(); // Start the backend process before showing the window

  // STEP 3: Configure window properties
  WindowOptions windowOptions = WindowOptions(
    // Initial window size (width x height in pixels)
    size: Size(550, 800),
    
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
    maximumSize: const Size(550, 800),
    minimumSize: const Size(550, 800),

    alwaysOnTop: true,
    
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
    await windowManager.setAlignment(Alignment.bottomRight);  // Aligns the window to the bottom right corner
  });

  // STEP 5: Start the Flutter application
  // Must go AFTER setting up the window, not before
  runApp(MainApp());
}

// Function to start the backend process
// Function to start the backend process
// Function to start the backend process invisibly


// Function to start the backend process invisibly
// Function to start the backend process
Future <void> runBackend() async {
  try {
    if (Platform.isWindows) {
      // Get the path to the main.exe file
      String backendPath = '${Directory.current.path}/data/flutter_assets/assets/backend/main.exe';

      // Check if the file exists at the expected location, if not, try the alternative path
      if (!await File(backendPath).exists()) {
        backendPath = '${Directory.current.path}/assets/backend/main.exe';
      }

      String workingDir = File(backendPath).parent.path;
      debugPrint('Running backend hidden from: $backendPath');

      // Ejecutamos a través de PowerShell con -WindowStyle Hidden
      // para que nunca se muestre la consola negra de fondo
      backendProcess = await Process.start(
        'powershell',
        [
          '-Command', 'Start-Process',
          '"$backendPath"',
          '-WindowStyle', 'Hidden',
          '-WorkingDirectory', '"$workingDir"'
        ],
        runInShell: true,
      );

    } else if (Platform.isMacOS) {
      // IMPORTANTE: en macOS, Directory.current.path puede apuntar al contenedor
      // sandbox de la app (Library/Containers/.../Data) en vez del bundle real,
      // especialmente en modo debug. Platform.resolvedExecutable sí es confiable:
      // siempre apunta a .../MiApp.app/Contents/MacOS/ejecutable
      String contentsPath = File(Platform.resolvedExecutable).parent.parent.path; // .../MiApp.app/Contents

      String backendPath = '$contentsPath/Resources/flutter_assets/assets/backend/main';

      if (!await File(backendPath).exists()) {
        // Fallback por si el asset se empaqueta en una subcarpeta distinta
        backendPath = '$contentsPath/Frameworks/assets/backend/main';
      }

      // Nos aseguramos de que el binario tenga permiso de ejecución
      await Process.run('chmod', ['+x', backendPath]);

      debugPrint('Running backend from: $backendPath');

      // El propio binario Python ya se encarga de pedir sudo (vía osascript) a través
      // de ensure_admin(), así que aquí solo lo lanzamos normal, sin necesidad de PowerShell.
      backendProcess = await Process.start(
        backendPath,
        [],
        workingDirectory: File(backendPath).parent.path,
      );

    } else {
      debugPrint('Plataforma no soportada para lanzar el backend automáticamente.');
      return;
    }

    debugPrint('Backend process started');
  } catch (e) {
    debugPrint('Error occurred while starting backend: $e');
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(// ValueListenableBuilder es un widget que escucha un ValueNotifier y reconstruye su contenido cada vez que el valor cambia.
      valueListenable: isDarkMode,
      builder: (context, isDark, child) {
        return MaterialApp(
          theme: isDark ? darkTheme : lightTheme,
          debugShowCheckedModeBanner: false,
          home: Homepage(),
        );
      },

    );
  }
}
