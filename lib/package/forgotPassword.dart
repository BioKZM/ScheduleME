import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final userInput = TextEditingController();
  String error = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(340, 0, 0, 0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 260, 0, 0),
                    child: Form(
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
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(37, 0, 0, 0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      await FirebaseAuth.instance
                                          .sendPasswordResetEmail(
                                              email: userInput.text);
                                      setState(() =>
                                          error = "Başarıyla gönderildi!");
                                    } catch (e) {
                                      setState(
                                          () => error = "Bir hata oluştu.");
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.red,
                                    minimumSize: const Size(129, 40),
                                  ),
                                  child: const Text("Gönder"),
                                ),
                              ),
                              const SizedBox(
                                width: 40,
                                height: 50,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              const SizedBox(
                                height: 40,
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
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
