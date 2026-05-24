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
      final gradleCaches = await http.get(Uri.parse('http://127.0.0.1:8000/gradle_caches'));
      final androidCaches = await http.get(Uri.parse('http://127.0.0.1:8000/android_caches'));
      final flutterCaches = await http.get(Uri.parse('http://127.0.0.1:8000/flutter_caches'));
      final pipCaches = await http.get(Uri.parse('http://127.0.0.1:8000/pip_caches'));

      // Checks if the HTTP status code is exactly 200 (OK)
      return response.statusCode == 200 &&
              gradleCaches.statusCode == 200 &&
              androidCaches.statusCode == 200 &&
              flutterCaches.statusCode == 200 &&
              pipCaches.statusCode == 200;

      
    } catch (e) {
      // Catches any connection errors, timeouts, or server down issues securely
      return false;
    }
  }
}