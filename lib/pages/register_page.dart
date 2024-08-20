import 'package:chat/components/button_widget.dart';
import 'package:chat/models/user_model.dart';
import 'package:chat/pages/contacs_page.dart';
import 'package:chat/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const id = 'register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  User user = User();
  String name = '', email = '', password = '', passwordConfirmation = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registrarse'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: Column(
              children: [
                TextField(
                  style: TextStyle(color: Colors.black),
                  keyboardType: TextInputType.name,
                  decoration: kTextFieldDecorationLogin.copyWith(
                    hintText: 'Ingrese nombre',
                  ),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                const SizedBox(
                  height: 10.0,
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
                  height: 10.0,
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  obscureText: true,
                  decoration: kTextFieldDecorationLogin.copyWith(
                    hintText: 'Repita contraseña',
                  ),
                  onChanged: (value) {
                    passwordConfirmation = value;
                  },
                ),
                const SizedBox(
                  height: 50.0,
                ),
                ButtonWidget(
                    tittleButton: 'Crear cuenta',
                    isLoading: isLoading,
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      dynamic response = await user.register(
                          context: context,
                          name: name,
                          email: email,
                          password: password,
                          passwordConfirmation: passwordConfirmation);
                      if (response != null) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('token', response['token']);

                        Navigator.pushReplacementNamed(
                            context, ContactsPage.id);
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }),
                const SizedBox(
                  height: 10.0,
                ),
                ButtonWidget(
                    tittleButton: 'Cancelar',
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ));
  }
}
