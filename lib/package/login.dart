import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduleme/services/auth.dart';

import '../services/user.dart';
// import 'courses.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final userInput = TextEditingController();
  final passwordInput = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();
  String error = "";

  @override
  void dispose() {
    passwordInput.dispose();
    userInput.dispose();
    super.dispose();
  }

// return StreamProvider<FUser?>.value(
//       initialData: FUser(),
//       value: AuthService().user,
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SingleChildScrollView(
                  child: Container(
                    // padding: EdgeInsets.symmetric(vertical: 0),
                    // color: Colors.red,
                    width: 300,
                    height: 65,
                    child: TextFormField(
                      // maxLength: 20,
                      validator: (val) => val!.isEmpty
                          ? 'E-posta kısmı boş bırakılamaz.'
                          : null,
                      controller: userInput,
                      decoration: const InputDecoration(
                        counterText: ' ',
                        // contentPadding:
                        //     EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        border: OutlineInputBorder(),
                        hintText: "E-posta: ",
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 0,
                  height: 15,
                ),
                SizedBox(
                    width: 300,
                    height: 65,
                    child: TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Lütfen şifrenizi giriniz.' : null,
                      obscureText: true,
                      controller: passwordInput,
                      decoration: const InputDecoration(
                        counterText: ' ',
                        border: OutlineInputBorder(),
                        hintText: "Şifre: ",
                      ),
                    )),
                const SizedBox(
                  width: 0,
                  height: 20,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // print(userInput.text);
                          // print(passwordInput.text);
                          dynamic user = await _authService.signENP(
                              userInput.text, passwordInput.text);
                          if (user == null) {
                            setState(
                                () => error = "E-posta veya şifre yanlış.");
                          } else {
                            Navigator.popAndPushNamed(context, "/main");
                          }
                          // if (user != null) {
                          //   print("Welcome!");
                          //   print(user.userid);
                          //   // ignore: use_build_context_synchronously
                          //   Navigator.popAndPushNamed(context, "/main");
                          // } else {
                          //   print(
                          //       "An Error has occurred. Please try again later.");
                          //   print(user.userid);
                          // }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                        minimumSize: const Size(129, 40),
                      ),
                      child: const Text("Giriş Yap"),
                    ),
                    const SizedBox(
                      width: 40,
                      height: 50,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/register");
                      },
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.red,
                        minimumSize: const Size(129, 40),
                      ),
                      child: const Text("Kayıt Ol"),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      error,
                      style: const TextStyle(
                          fontFamily: "NotoSansBold",
                          fontSize: 15,
                          color: Colors.red),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
