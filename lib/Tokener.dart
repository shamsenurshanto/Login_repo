import 'package:http/http.dart' as http;

// Create a global variable to hold the cookie value
String? jwtToken;

void main() async {
  // Make a request to the Node.js server to get a JWT token
  final response = await http.get(Uri.parse('http://your-nodejs-server.com/get-jwt-token'));

  // Extract the JWT token from the response body
  final jwtToken = response.body;

  // Save the JWT token as a global variable
  MyCookieClass.jwtToken = jwtToken;

  // Make a request to a protected endpoint, sending the JWT token in the cookie
  final protectedResponse = await http.get(
    Uri.parse('http://your-nodejs-server.com/protected-endpoint'),
    headers: {'Cookie': 'jwt_token=${MyCookieClass.jwtToken}'},
  );
}

class MyCookieClass {
  static String? jwtToken;
}