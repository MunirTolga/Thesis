import 'package:flutter/material.dart';
import 'welcome_page.dart'; // WelcomePage'e yönlendirme için import
import 'login_page.dart'; // LoginPage'e yönlendirme için import
import '../services/api_service.dart'; // ApiService'e erişmek için import
import '../models/user.dart'; // User modeline erişmek için import

class RegisterPage extends StatefulWidget {
  final ApiService apiService; 

  const RegisterPage({Key? key, required this.apiService}) : super(key: key); 

  @override
  _RegisterPageState createState() => _RegisterPageState();
}


class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Registration',
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
              SizedBox(height: 20),
              _buildTextField('Confirm Password', 'Confirm your Password', _confirmPasswordController, isPassword: true),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _agreedToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreedToTerms = value!;
                      });
                    },
                  ),
                  Text("I agree to terms & conditions"),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_isInputValid()) {
                    if (_agreedToTerms) {
                      // Kullanıcıyı kaydet ve işlemi tamamla
                      User newUser = User(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      widget.apiService.registerUser(newUser);
                    

                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      _showSnackBar(context, 'Please approve the terms & conditions');
                    }
                  } else {
                    _showSnackBar(context, 'Please fill all information correctly');
                  }
                },
                child: Text('Sign Up'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already Have an Account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text(
                      'Login Here',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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

  bool _isInputValid() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();


    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      return false;
    }


    if (password != confirmPassword) {
      return false;
    }


    if (!_agreedToTerms) {
      return false;
    }

    return true;
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
