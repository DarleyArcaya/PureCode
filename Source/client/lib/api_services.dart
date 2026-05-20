import 'package:http/http.dart' as http;

class ApiServices {
  static Future<bool> runAllCleaners() async {
    
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/clean_all_caches'));
      return response.statusCode == 200;
      
    } catch (e) {
      return false;
    }
  }
}