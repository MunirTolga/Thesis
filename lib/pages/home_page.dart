import 'package:flutter/material.dart';
import 'help_page.dart'; // ChatbotPage'e yönlendirme için import

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Your AI Assistant',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Using this software, you can ask your questions and receive articles using artificial intelligence assistant.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Image.asset(
                'assets/images/ai_image.jpg', // Resim dosyasının yolunu belirtin
                width: 200,
                height: 200,
                fit: BoxFit.contain, // Resmi boyutlandırma yöntemi
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage()));
                },
                child: Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
