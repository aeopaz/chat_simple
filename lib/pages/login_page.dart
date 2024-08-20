import 'package:chat/models/user_model.dart';
import 'package:chat/pages/contacs_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:chat/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:chat/components/button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const id = 'login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  User user = User();
  String email = '', password = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    chectoken();
  }

  void chectoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      Navigator.pushReplacementNamed(context, ContactsPage.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'CHAT',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 50.0,
                ),
              ),
              const Text(
                'MESSENGER',
                style: TextStyle(color: Colors.blueAccent, fontSize: 20.0),
              ),
              const SizedBox(
                height: 80.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.emailAddress,
                decoration: kTextFieldDecorationLogin.copyWith(
                  hintText: 'Ingrese email',
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                obscureText: true,
                decoration: kTextFieldDecorationLogin.copyWith(
                  hintText: 'Ingrese contraseña',
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
              const SizedBox(
                height: 40.0,
              ),
              ButtonWidget(
                tittleButton: 'Ingresar',
                isLoading: isLoading,
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  dynamic token = await user.getToken(
                      context: context, email: email, password: password);
                  if (token != null) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('token', token['token']);
                    Navigator.pushReplacementNamed(context, ContactsPage.id);
                  }
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              ButtonWidget(
                tittleButton: 'Registrarse',
                onPressed: () =>
                    {Navigator.pushNamed(context, RegisterPage.id)},
              )
            ],
          ),
        ),
      ),
    );
  }
}
