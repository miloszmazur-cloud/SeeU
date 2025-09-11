import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learning/main.dart';
import 'package:learning/createa.dart';
import 'package:crypto/crypto.dart';

 void main() {
  runApp(MaterialApp(
    title: 'Login Screen',
    home: LoginScreen(),
  ));
}

String susername = '';
String token = '';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    String hashWithSHA1(String input) {
  var bytes = utf8.encode(input); // Encode the input string as UTF-8
  var digest = sha1.convert(bytes); // Generate the SHA-1 hash
  return digest.toString(); // Return the hashed string
}
      String hashedPassword = hashWithSHA1(password); 

    String url = 'http://xx.xx.xx.xx/loginUser';
    try {
      final response = await http.post(Uri.parse(url),
      headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'login': username,
          'password': hashedPassword,
        }),);
      
      if (response.statusCode == 200) {
        susername = username;
        var jsonResponse = response.body;
        token = jsonResponse;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FirstRoute()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed. Please try again.'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again later.'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        shape: Border(bottom: BorderSide.none),
        backgroundColor: Colors.black,
        actions: [
        TextButton(
            
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered))
          return Colors.orange.withOpacity(0);
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed))
          return Colors.orange.withOpacity(0);
        return null; // Defer to the widget's default.
      },
    ),
  ),
  onPressed: () { },
  child: new Text(
    "LOGIN                         ",
    style: new TextStyle(
    
      fontSize: 41.1,
)
  ),
    ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'USERNAME'),
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'PASSWORD'),
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              ),
              onPressed: () {
                _login(context);
              },
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 40.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 50),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateAccountScreen()),
                );
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 17, 17, 17)),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered))
                      return Colors.orange.withOpacity(0.08);
                    if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed))
                      return Colors.orange.withOpacity(0.12);
                    return null;
                  },
                ),
              ),
              child: const Text(
                "CREATE ACCOUNT",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
