import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/contacs_page.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.black))),
      initialRoute: LoginPage.id,
      debugShowCheckedModeBanner: false,
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ContactsPage.id: (context) => ContactsPage(),
        ChatPage.id: (context) => ChatPage()
      },
    );
  }
}
