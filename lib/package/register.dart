import 'package:flutter/material.dart';

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
  final classInput = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(children: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_rounded)),
          ]),
          const SizedBox(
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
                                  ? 'Ad kısmı boş bırakılamaz'
                                  : null,
                              controller: nameInput,
                              decoration: const InputDecoration(
                                counterText: ' ',
                                border: OutlineInputBorder(),
                                hintText: "Ad: ",
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
                                  ? 'Soyad kısmı boş bırakılamaz'
                                  : null,
                              controller: surnameInput,
                              decoration: const InputDecoration(
                                counterText: ' ',
                                border: OutlineInputBorder(),
                                hintText: "Soyad: ",
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
                                    ? 'Bölüm boş bırakılamaz'
                                    : null,
                                controller: classInput,
                                decoration: const InputDecoration(
                                  counterText: ' ',
                                  border: OutlineInputBorder(),
                                  hintText: "Bölüm: ",
                                ),
                              )),
                          const SizedBox(
                            width: 0,
                            height: 20,
                          ),
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
                                      nameInput.text,
                                      surnameInput.text,
                                      userInput.text,
                                      passwordInput.text,
                                      classInput.text,
                                    );
                                    if (result == null) {
                                      setState(() => error =
                                          "Lütfen geçerli bir e-posta adresi giriniz.");
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      Navigator.popAndPushNamed(
                                          context, "/main");
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.red,
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
