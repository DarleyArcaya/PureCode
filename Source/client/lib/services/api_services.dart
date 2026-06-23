import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

}