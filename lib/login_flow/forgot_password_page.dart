import 'package:flexiares/login_flow/reset_password_screen.dart';
import 'package:flexiares/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _requestForgotPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await http.post(
          Uri.parse(forgotPasswordUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': _emailController.text}),
        );

        final responseBody = jsonDecode(response.body);

        print(responseBody);
        print(response.statusCode);


        if (response.statusCode == 200) {

          try {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(responseBody['message'])),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResetPasswordScreen(),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(responseBody['email'][0])),
            );
          }
        } else {

          try {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to request password reset.')),
            );
          }catch(e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(responseBody['email'][0])),
            );
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _requestForgotPassword,
                child: Text('Request Password Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
