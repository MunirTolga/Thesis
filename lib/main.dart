import 'package:flutter/material.dart';
import '/pages/welcome_page.dart';
import '/pages/login_page.dart';
import '/pages/register_page.dart';
import '/pages/home_page.dart';
import '/pages/help_page.dart';
import 'services/api_service.dart'; 
//import '/pages/chatbot_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Chatbot App',
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(apiService: ApiService()), // ApiService ekleniyor
        '/home': (context) => HomePage(),
        '/help': (context) => HelpPage(),
        //'/chatbot': (context) => ChatbotPage(),
      },
    );
  }
}
