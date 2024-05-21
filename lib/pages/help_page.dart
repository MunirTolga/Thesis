import 'package:flutter/material.dart';
//import 'chatbot_page.dart'; // ChatbotPage'e yönlendirme için import

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue, // Açık mavi renk
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'List the symptoms by your illness, and find out what your illness is using your app',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Your daily health tip is waiting for you each day',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Diagnosis chatbot is completely free',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Use the latest version of the Diagnosis Chatbot for improvements and new features',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'If you have something to tell about the app please contact us!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            Divider(
              color: Colors.blue, // Mavi renkli kalın çizgi
              thickness: 2.0,
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Image.asset(
                  'assets/images/logo.png', // Sol kısımdaki fotoğrafın dosya yolu
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'v1.0.0',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Contact Us',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'xyz@iyte.edu.tr',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
