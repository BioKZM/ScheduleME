import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../services/auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final userInput = TextEditingController();
  final passwordInput = TextEditingController();
  final nameInput = TextEditingController();
  final surnameInput = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_rounded)),
              ]),
          SizedBox(
            height: 70,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                  key: _formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 300,
                            height: 65,
                            child: TextFormField(
                              validator: (val) => val!.isEmpty
                                  ? 'İsim kısmı boş burakılamaz'
                                  : null,
                              controller: nameInput,
                              decoration: const InputDecoration(
                                counterText: ' ',
                                border: OutlineInputBorder(),
                                hintText: "İsim: ",
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 0,
                            height: 20,
                          ),
                          SizedBox(
                            width: 300,
                            height: 65,
                            child: TextFormField(
                              validator: (val) => val!.isEmpty
                                  ? 'Soy isim kısmı boş burakılamaz'
                                  : null,
                              controller: surnameInput,
                              // obscureText: true,
                              decoration: const InputDecoration(
                                counterText: ' ',
                                border: OutlineInputBorder(),
                                hintText: "Soy İsim: ",
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 0,
                            height: 20,
                          ),
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
                                validator: (val) => val!.length < 6
                                    ? 'Şifre minimum 6 karakterden oluşmalı.'
                                    : null,
                                controller: passwordInput,
                                obscureText: true,
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
                          Column(
                            children: <Widget>[
                              const SizedBox(
                                width: 40,
                                height: 50,
                              ),
                              OutlinedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    dynamic result =
                                        await _authService.registerENP(
                                      userInput.text,
                                      passwordInput.text,
                                      nameInput.text,
                                      surnameInput.text,
                                    );
                                    if (result == null) {
                                      setState(() => error =
                                          "Lütfen geçerli bir e-posta adresi giriniz.");
                                    } else {
                                      Navigator.popAndPushNamed(
                                          context, "/main");
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  onPrimary: Colors.white,
                                  minimumSize: const Size(129, 40),
                                ),
                                child: const Text("Kayıt Ol"),
                              ),
                              Column(children: <Widget>[
                                Text(
                                  error,
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontFamily: "NotoSansBold",
                                      fontSize: 15),
                                )
                              ])
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
