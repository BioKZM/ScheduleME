import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                },
                icon: const Icon(Icons.exit_to_app_rounded),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: const <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/qRnt.png"),
                        radius: 40,
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(
                            children: const [
                              SizedBox(
                                height: 15,
                              )
                            ],
                          ),
                          Row(
                            children: const <Widget>[
                              Text(
                                "Berke Akbay",
                                style: TextStyle(
                                  fontFamily: "ArabatoMedium",
                                  fontSize: 22.0,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: const <Widget>[
                              Text(
                                "Bilgisayar Mühendisliği",
                                style: TextStyle(
                                  fontFamily: "ArabatoNormal",
                                  fontSize: 16.0,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: const [
                              SizedBox(
                                height: 15,
                              )
                            ],
                          ),
                          Container(
                            width: screenWidth,
                            height: 10,
                            color: Colors.grey.withOpacity(0.1),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          const Text(
                            "Devamsızlıklar",
                            style: TextStyle(
                              fontFamily: "ArabatoMedium",
                              fontSize: 18,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                  height: 150,
                                  width: 100,
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Colors.grey.withOpacity(0.4),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(4),
                                          )),
                                      color: Colors.red.withOpacity(0.1),
                                      elevation: 0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: const [
                                              SizedBox(
                                                height: 6,
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const <Widget>[
                                              Icon(
                                                Icons
                                                    .indeterminate_check_box_rounded,
                                                color: Colors.red,
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const <Widget>[
                                              Text("deneme"),
                                            ],
                                          ),
                                        ],
                                      ))),
                              SizedBox(
                                  height: 150,
                                  width: 100,
                                  child: Card(
                                      color: Colors.amber.withOpacity(0.1),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Colors.grey.withOpacity(0.4),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(4))),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: const [
                                              SizedBox(
                                                height: 6,
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.warning_rounded,
                                                color: Colors.amber[700],
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const <Widget>[
                                              Text("deneme"),
                                            ],
                                          ),
                                        ],
                                      ))),
                              SizedBox(
                                  height: 150,
                                  width: 100,
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Colors.grey.withOpacity(0.4),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(4),
                                          )),
                                      color: Colors.green.withOpacity(0.1),
                                      elevation: 0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: const [
                                              SizedBox(
                                                height: 6,
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const <Widget>[
                                              Icon(
                                                Icons.add_box_rounded,
                                                color: Colors.green,
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const <Widget>[
                                              Text("deneme"),
                                            ],
                                          ),
                                        ],
                                      )))
                            ],
                          ),
                          const SizedBox(
                            width: 0,
                            height: 15,
                          ),
                          Container(
                            color: Colors.grey.withOpacity(0.1),
                            width: screenWidth,
                            height: 10,
                          ),
                          // const SizedBox(
                          //   width: 0,
                          //   height: 15,
                          // ),
                          const Text(
                            "Gruplar",
                            style: TextStyle(
                              fontFamily: "ArabatoMedium",
                              fontSize: 18,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 200,
                                height: 150,
                                child: Card(
                                  color: Colors.blue.withOpacity(0.15),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.grey.withOpacity(0.4),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(4),
                                    ),
                                  ),
                                  elevation: 0,
                                  child: Column(
                                    children: <Widget>[
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const <Widget>[
                                          Text("Test"),
                                        ],
                                      ),
                                      Row(
                                        children: const <Widget>[
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text("Test"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                height: 150,
                                child: Card(
                                  color: Colors.purple.withOpacity(0.1),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.grey.withOpacity(0.4),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(4),
                                    ),
                                  ),
                                  elevation: 0,
                                  child: Column(
                                    children: <Widget>[
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const <Widget>[
                                          Text("Aktif Dersler"),
                                        ],
                                      ),
                                      Row(
                                        children: const <Widget>[
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text("5"),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
