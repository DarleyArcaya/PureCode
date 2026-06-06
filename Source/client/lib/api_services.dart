import 'package:http/http.dart' as http;


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
  
 static Future<bool> removeCacheMac() async {
  try {
    final mac = await http.get(Uri.parse('http://127.0.0.1:8000/check_updates'));
    return mac.statusCode == 200;
  } catch (e) {
    return false;
  }
 }

}