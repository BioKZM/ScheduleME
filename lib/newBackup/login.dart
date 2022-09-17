import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final mailInput = TextEditingController();
  final passwordInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                height: 200,
              ),
              SizedBox(
                height: 100,
                width: 200,
                child: TextFormField(
                    validator: (val) =>
                        val!.isEmpty ? 'E-posta kısmı boş bırakılamaz.' : null,
                    controller: mailInput,
                    decoration: const InputDecoration(
                      counterText: ' ',
                      border: OutlineInputBorder(),
                      hintText: "E-posta",
                    )),
              ),
              SizedBox(
                height: 100,
                width: 150,
                child: TextFormField(
                    validator: (val) =>
                        val!.isEmpty ? 'Şifre kısmı boş bırakılamaz.' : null,
                    controller: passwordInput,
                    obscureText: true,
                    decoration: const InputDecoration(
                      counterText: ' ',
                      border: OutlineInputBorder(),
                      hintText: "Şifre",
                    )),
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                child: const Text("Giriş Yap"),
                onPressed: () async {
                  UserCredential user =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: mailInput.text,
                    password: passwordInput.text,
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
