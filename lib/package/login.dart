import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scheduleme/package/home.dart';
import 'package:scheduleme/services/auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final userInput = TextEditingController();
  final passwordInput = TextEditingController();
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = "";

  @override
  void dispose() {
    passwordInput.dispose();
    userInput.dispose();
    super.dispose();
  }

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
                  child: SizedBox(
                    width: 300,
                    height: 65,
                    child: TextFormField(
                      validator: (val) => val!.isEmpty
                          ? 'E-posta kısmı boş bırakılamaz.'
                          : null,
                      controller: userInput,
                      decoration: const InputDecoration(
                        counterText: ' ',
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
                Padding(
                  padding: EdgeInsets.fromLTRB(216, 0, 0, 0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        "/forgotPassword",
                      );
                      // FirebaseAuth.instance
                      //     .sendPasswordResetEmail(email: userInput.text);
                    },
                    child: const Text(
                      "Şifremi Unuttum",
                      style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.underline,
                          fontSize: 13),
                    ),
                  ),
                  // child: RichText(
                  //     text: TextSpan(
                  //   text: "Şifremi Unuttum",
                  //   style: TextStyle(
                  //     color: Colors.grey,
                  //   ),
                  // ))
                  // child: Text("Şifremi Unuttum",
                  //     style: TextStyle(
                  //       color: Colors.grey,
                  //       decoration: TextDecoration.underline,
                  //     )),
                ),
                const SizedBox(
                  width: 0,
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            dynamic user = await _authService.signIn(
                                userInput.text, passwordInput.text);
                            if (user != null) {
                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.pushNamed(
                                  context,
                                  "/main",
                                );
                              });
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == "wrong-password") {
                              setState(
                                  () => error = "E-posta veya şifre yanlış!");
                            } else if (e.code == "invalid-email") {
                              setState(() => error = "E-posta adresi yanlış!");
                            } else if (e.code == "user-not-found") {
                              setState(() => error = "Kullanıcı bulunamadı.");
                            } else if (e.code == "user-disabled") {
                              setState(() => error =
                                  "Kullanıcı hesabı devre dışı bırakılmış.Lütfen desteğe başvur.");
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
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
                        Navigator.pushNamed(
                          context,
                          "/register",
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        minimumSize: const Size(129, 40),
                      ),
                      child: const Text("Kayıt Ol"),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      error,
                      style: const TextStyle(
                          fontFamily: "NotoSansBold",
                          fontSize: 15,
                          color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
