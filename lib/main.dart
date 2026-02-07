import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:folder/firebase_options.dart';
import 'package:folder/pages/chat_page.dart';
import 'package:folder/pages/login_page.dart';
import 'package:folder/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ChatPage.id: (context) => ChatPage(),

      },
      initialRoute: LoginPage.id,

      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
