import 'package:flutter/cupertino.dart'; // This library is used for building iOS-style applications in Flutter. It provides a set of widgets and tools that follow the design principles of Apple's iOS platform, allowing developers to create apps with a native look and feel on iOS devices.
import 'package:flutter/material.dart'; // This library is used for building Material Design applications in Flutter. It provides a comprehensive set of widgets and tools that follow Google's Material Design guidelines, enabling developers to create visually appealing and responsive apps for Android and other platforms.
import 'package:http/http.dart' as http; // This library is used for making HTTP requests in Flutter. It provides a simple and convenient way to send GET, POST, PUT, DELETE, and other types of HTTP requests to web servers, allowing developers to interact with APIs and retrieve or send data over the internet.
import 'dart:convert'; // this library is in charge of converting text to JSON in the check_update function

/// A service class responsible for managing API communications 
/// between the Flutter frontend and the FastAPI backend.
class ApiServices {

  /// Sends a request to the backend to execute all system cache cleaners.
  /// 
  /// Returns `true` if the server responds with a 200 OK status code,
  /// indicating a successful cleanup. Returns `false` otherwise.
  static Future<bool> runAllCleaners() async {
    
    try {

      // Performs an asynchronous GET request to cleanup endpoint
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/clean_all_caches'));


      // Checks if the HTTP status code is exactly 200 (OK)
      return response.statusCode == 200;


      
    } catch (e) {
      // Catches any connection errors, timeouts, or server down issues securely
      return false;
    }
  }

 static Future<bool> removeGradleCaches() async {
  try {
    final gradleCaches = await http.get(Uri.parse('http://127.0.0.1:8000/gradle_caches'));
    return gradleCaches.statusCode == 200;
  } catch (e) {
    return false;
  }
 }

 static Future<bool> removeAndroidCaches () async {
  try{
    final androidCaches = await http.get(Uri.parse('http://127.0.0.1:8000/android_caches'));
    return androidCaches.statusCode == 200;
  } catch (e) {
    return false;
  }
 }
  
 static Future<bool> removeFlutterCaches() async {
  try {
    final flutterCaches = await http.get(Uri.parse('http://127.0.0.1:8000/flutter_caches'));
    return flutterCaches.statusCode == 200;
  } catch (e) {
    return false;
  }
 }

 static Future<bool> removePipPythonCaches() async {
  try{
    final pipCaches = await http.get(Uri.parse('http://127.0.0.1:8000/pip_caches'));
    return pipCaches.statusCode == 200;
  } catch (e) {
    return false;
  }
 }
  
 static Future<void> checkUpdates(BuildContext context) async { // Here we are creating the connection from the api to flutter for get updates notifications
  try {
    final update = await http.get(Uri.parse('http://127.0.0.1:8000/check_updates'));
    if (update.statusCode == 200){
      final data = json.decode(update.body); // we are using the library convert to use this code line and convert text to JSON
      
      if (data['has_update'] == true){
        //_showUpdateDialog(context, data['latest_version']);
      }

    
    }
  } catch (e) {
    debugPrint("There is an error with updates:  $e");

  } 
  
 }

 static Future<bool> optimizeSystem() async {
  try {
    final optimization = await http.get(Uri.parse('http://127.0.0.1:8000/optimization'));
    return optimization.statusCode == 200;

  } catch (e) {
    debugPrint("There is an error with optimization: $e");
    return false;
  }
 }

 static Future<String> lastOptimization() async {
  try {
    final lastOptimization = await http.get(Uri.parse('http://127.0.0.1:8000/last_optimization'));
    if (lastOptimization.statusCode == 200) {
     final data = json.decode(lastOptimization.body);
  
      final date = data['last_optimization_date'].toString(); // we use toString() to convert the date and time to string format for display purposes
      final time = data['last_optimization_time'].toString();
      final status = data['last_optimization_status'].toString();
    
  return "\n✅$date  \n✅$time \n✅($status)";
      
    } else {
      debugPrint('Failed to fetch last optimization: ${lastOptimization.statusCode}');
      return 'Server not connected';
    }

  } catch (e) {
    debugPrint('EXPLOTION IN FLUTTER: $e');
    return 'Processing Error';
    
  }
 }

 static Future<String> getGbSaved() async {
  try {
    final gbSaved = await http.get(Uri.parse('http://127.0.0.1:8000/get_size'));
    if (gbSaved.statusCode == 200)  {
      final data = json.decode(gbSaved.body);

      final temp_folder = data['temp_folder_size'].toString();
      final windows_temp = data['windows_temp_size'].toString();
      final windows_pretfetch = data['windows_prefecth_size'].toString();

      return "\n✅Temp Folder: $temp_folder  \n✅Windows Temp: $windows_temp \n✅Windows Prefetch: $windows_pretfetch";
      
    } else {
      debugPrint('Failed to fetch GB saved: ${gbSaved.statusCode}');
      return 'Server not connected';
    }
  } catch (e) {
    debugPrint('Error fetching GB saved: $e');
    return 'Error fetching GB saved';
  }
  }
 } 
