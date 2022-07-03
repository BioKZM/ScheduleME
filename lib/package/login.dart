import 'package:flutter/material.dart';
import 'package:scheduleme/services/auth.dart';
// import 'courses.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final userInput = TextEditingController();
  final passwordInput = TextEditingController();

  final AuthService _authService = AuthService();

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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 45,
              child: TextField(
                controller: userInput,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Kullanıcı Adı: ",
                ),
              ),
            ),
            const SizedBox(
              width: 0,
              height: 15,
            ),
            SizedBox(
                width: 300,
                height: 45,
                child: TextField(
                  obscureText: true,
                  controller: passwordInput,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Şifre: ",
                  ),
                )),
            const SizedBox(
              width: 0,
              height: 10,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlinedButton(
                  onPressed: () async {
                    print(userInput.text);
                    print(passwordInput.text);
                    dynamic user = await _authService.signInAnon();
                    if (user != null) {
                      print("Welcome!");
                      Navigator.pushNamed(context, "/main");
                    } else {
                      print("An Error has occurred. Please try again later.");
                      print(user);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.red,
                    minimumSize: const Size(137, 40),
                  ),
                  child: const Text("Giriş Yap"),
                ),
                const SizedBox(
                  width: 40,
                  height: 50,
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.red,
                    minimumSize: const Size(137, 40),
                  ),
                  child: const Text("Kayıt Ol"),
                ),
              ],
            ),
          ],
        ),
      ],
    ));
  }
}
