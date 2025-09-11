import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

String serverUrl = 'http://xx.xx.xx.xx';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  final snackBar = SnackBar(
    content: Text('Please make sure none of the fields are empty'),
    duration: Duration(seconds: 2),
  );
  final snackBar2 = SnackBar(
    content: Text('Account created successfully'),
    duration: Duration(seconds: 2),
  );
  final snackBar3 = SnackBar(
    content: Text('Such a user already exists'),
    duration: Duration(seconds: 2),
  );

  Future<void> _createAccount() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();
    final String email = _emailController.text.trim();

    String hashWithSHA1(String input) {
      var bytes = utf8.encode(input);
      var digest = sha1.convert(bytes);
      return digest.toString();
    }
    

    String hashedPassword = hashWithSHA1(password);
    String url = 'http://xx.xx.xx.xx/createUser';

    if (username.isNotEmpty && password.isNotEmpty && email.isNotEmpty) {
      try {
        final response = await http.post(Uri.parse(url),
             headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'login': username,
          'password': hashedPassword,
          'mail': email,
        }),
        );
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar2);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(snackBar3);
        }
      } catch (e) {
        print('Error: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
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
                  return null;
                },
              ),
            ),
            onPressed: () {},
            child: new Text(
              "CREATE ACCOUNT   ",
              style: new TextStyle(
                fontSize: 41.1,
              ),
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
              decoration: InputDecoration(
                labelText: 'USERNAME'),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'PASSWORD'),
              style: TextStyle(color: Colors.white),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'EMAIL'),
              style: TextStyle(color: Colors.white),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
              ),
              child: Icon(
                size: 40.0,
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                _createAccount();
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CreateAccountScreen(),
  ));

}
