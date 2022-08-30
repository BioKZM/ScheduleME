import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings_ extends StatefulWidget {
  const Settings_({Key? key}) : super(key: key);

  @override
  State<Settings_> createState() => _Settings_State();
}

class _Settings_State extends State<Settings_> {
  final nameInput = TextEditingController();
  final surnameInput = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  var nameVariable = "";
  bool nameSwap = false;
  bool surnameSwap = false;

  @override
  Widget build(BuildContext context) {
    Widget nameBox = Container();
    Widget surnameBox = Container();
    Widget nameEditIcon = Container();
    Widget surnameEditIcon = Container();
    Widget classBox = Container();
    Widget classEditIcon = Container();

    if (nameSwap == true) {
      nameBox = Column(
        children: [
          SizedBox(
              width: 250,
              height: 40,
              child: TextFormField(
                controller: nameInput,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: nameVariable,
                ),
              )),
        ],
      );
      surnameBox = Column(
        children: [
          Container(
            height: 40,
            width: 250,
            color: Colors.grey,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Akbay",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      );
      classBox = Column(
        children: [
          Container(
            height: 40,
            width: 250,
            color: Colors.grey,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Bilgisayar Mühendisliği",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );

      nameEditIcon = Column(
        children: [
          IconButton(
            onPressed: () {
              setState(
                () {
                  nameSwap = !nameSwap;
                },
              );
            },
            icon: Icon(Icons.check),
          ),
        ],
      );
    } else if (surnameSwap == true) {
      nameBox = Column(
        children: [
          Container(
            height: 40,
            width: 250,
            color: Colors.grey,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Berke",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      );
      surnameBox = Column(
        children: [
          SizedBox(
              width: 250,
              height: 40,
              child: TextFormField(
                controller: surnameInput,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: nameVariable,
                ),
              )),
        ],
      );
      surnameEditIcon = Column(
        children: [
          IconButton(
            onPressed: () {
              setState(
                () {
                  surnameSwap = !surnameSwap;
                },
              );
            },
            icon: Icon(Icons.check),
          ),
        ],
      );
    } else {
      nameBox = Column(
        children: [
          Container(
            height: 40,
            width: 250,
            color: Colors.grey,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Berke",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      );
      surnameBox = Column(
        children: [
          Container(
            height: 40,
            width: 250,
            color: Colors.grey,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Akbay",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      );
      nameEditIcon = Column(
        children: [
          IconButton(
            onPressed: () {
              setState(
                () {
                  nameSwap = !nameSwap;
                },
              );
            },
            icon: Icon(Icons.mode_edit_outlined),
          ),
        ],
      );
      surnameEditIcon = Column(
        children: [
          IconButton(
            onPressed: () {
              setState(
                () {
                  surnameSwap = !surnameSwap;
                },
              );
            },
            icon: Icon(Icons.mode_edit_outlined),
          ),
        ],
      );
    }

    // Row(
    //           children: [
    //             Column(
    //               children: [
    //                 Container(
    //                   height: 40,
    //                   width: 250,
    //                   color: Colors.grey,
    //                   child: const Align(
    //                     alignment: Alignment.centerLeft,
    //                     child: Text(
    //                       "Berke Akbay",
    //                       style: TextStyle(color: Colors.white),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             Column(
    //               children: [
    //                 IconButton(
    //                     onPressed: () {}, icon: Icon(Icons.mode_edit_outlined)),
    //               ],
    //             ),
    //           ],
    //         ),

    // CollectionReference data = _firestore.collection('brews');
    // var userData = data.doc('${user!.email}');
    // // print(data.get().docs.data());
    // print(data.get());
    return Scaffold(
        body: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 100),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage("assets/placeholder.jpg"),
                      radius: 40,
                    ),
                    Positioned(
                      left: 40,
                      bottom: 45,
                      // right: 0,
                      // top: 0,
                      // left: 40,
                      // bottom: 120,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.camera_alt, size: 23),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: const [
                SizedBox(
                  height: 40,
                  width: 250,
                ),
              ],
            ),
            Row(
              children: [nameBox, nameEditIcon],
            ),
            Row(
              children: [surnameBox, surnameEditIcon],
            ),
            // Row(children: [
            //   SizedBox(
            //       width: 250,
            //       height: 40,
            //       child: TextFormField(
            //         controller: nameInput,
            //         decoration: InputDecoration(
            //           border: OutlineInputBorder(),
            //           hintText: nameVariable,
            //         ),
            //       ))
            // ]),
            // Row(
            //   children: [
            //     Column(
            //       children: [
            //         Container(
            //           height: 40,
            //           width: 250,
            //           color: Colors.grey,
            //           child: const Align(
            //             alignment: Alignment.centerLeft,
            //             child: Text(
            //               "Berke Akbay",
            //               style: TextStyle(color: Colors.white),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         IconButton(
            //             onPressed: () {}, icon: Icon(Icons.mode_edit_outlined)),
            //       ],
            //     ),
            //   ],
            // ),
            Row(
              children: const [
                SizedBox(
                  height: 10,
                  width: 250,
                ),
              ],
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 250,
                  color: Colors.grey,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Bilgisayar Mühendisliği",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ));
    // return Scaffold(
    //     body: Row(
    //   children: <Widget>[
    //     const Text("Settings"),
    //     ElevatedButton(
    //         onPressed: () {
    //           Navigator.pushNamed(context, "/login");
    //         },
    //         child: const Text("Çıkış Yap"))
    //   ],
    // ));
  }
}
