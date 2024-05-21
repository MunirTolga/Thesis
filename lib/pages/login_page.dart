import 'package:flutter/material.dart';
import 'welcome_page.dart';
import 'register_page.dart';
import '../services/api_service.dart'; // ApiService'i dahil edin
import '../models/user.dart'; // User modelini dahil edin

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WelcomePage()),
            );
          },
        ),
      ),
      body: Center(
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Login',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 30),
          _buildTextField('Email', 'Enter your Email', _emailController),
          SizedBox(height: 20),
          _buildTextField('Password', 'Enter your Password', _passwordController, isPassword: true),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              String enteredEmail = _emailController.text.trim();
              String enteredPassword = _passwordController.text.trim();

              // Kullanıcının girdiği email ile veritabanındaki tüm email'leri kontrol et
              List<String> emails = await ApiService.getAllUserEmails();
              bool isEmailCorrect = emails.contains(enteredEmail);

              if (isEmailCorrect) {
                // Eğer email doğru ise, kullanıcının girdiği password'u kontrol et
                String passwordFromDatabase = await ApiService.getUserPasswordByEmail(enteredEmail);
                if (passwordFromDatabase == enteredPassword) {
                  // Kullanıcının giriş yaptığını belirten bilgiyi User modeline aktar
                  User loggedInUser = User(email: enteredEmail, password: enteredPassword);
                  // Ana sayfaya yönlendir
                  Navigator.pushReplacementNamed(context, '/home', arguments: loggedInUser);
                } else {
                  _showSnackBar(context, 'Password is wrong. Please try again!');
                }
              } else {
                _showSnackBar(context, 'Email is wrong. Please try again!');
              }
            },
            child: Text('Sign In'),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Doesn't have an account yet?"),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(apiService: ApiService())));
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String labelText, String hintText, TextEditingController controller, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
