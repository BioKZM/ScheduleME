import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Settings_ extends StatefulWidget {
  const Settings_({Key? key}) : super(key: key);

  @override
  State<Settings_> createState() => _Settings_State();
}

class _Settings_State extends State<Settings_> {
  TextEditingController nameInput = TextEditingController();
  TextEditingController classInput = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _firebase = FirebaseStorage.instance;
  User? user = FirebaseAuth.instance.currentUser;
  var imageURL;
  bool swap = false;
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    DocumentReference<Object?> userData;
    CollectionReference data = _firestore.collection('brews');
    userData = data.doc('${user!.email}');

    Widget nameBox = Container();
    Widget nameEditIcon = Container();
    Widget classBox = Container();
    Widget classEditIcon = Container();
    Widget iconButton = Container();
    Widget iconBox = Container();

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: userData.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.active) {
            var list = snapshot.data.data();
            var name = list['name'];
            var class_ = list['class'];
            var imageURL = list['imageURL'];
            nameInput.text = name;
            classInput.text = class_;

            if (swap == true) {
              nameBox = Column(
                children: [
                  SizedBox(
                      width: 250,
                      height: 40,
                      child: TextFormField(
                        controller: nameInput,
                        cursorColor: Colors.red,
                        decoration: const InputDecoration(
                          labelText: "İsim",
                          labelStyle: TextStyle(color: Colors.red),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      )),
                ],
              );
              classBox = Column(
                children: [
                  SizedBox(
                      width: 250,
                      height: 40,
                      child: TextFormField(
                        controller: classInput,
                        decoration: const InputDecoration(
                          labelText: "Bölüm",
                          labelStyle: TextStyle(color: Colors.red),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      )),
                ],
              );
              iconButton = Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 340),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            swap = !swap;
                          });
                          userData.update({
                            'name': nameInput.text,
                            'class': classInput.text
                          });
                        },
                        icon: const Icon(Icons.check)),
                  ),
                ],
              );
              iconBox = Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(imageURL),
                        backgroundColor: Colors.transparent,
                      ),
                      Positioned(
                        left: 98,
                        bottom: 105,
                        child: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () async {
                            await Permission.photos.request();

                            var permissionStatus =
                                await Permission.photos.status;
                            if (permissionStatus.isGranted) {
                              XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery);
                              var file = File(image!.path);

                              var snapshot = await _firebase
                                  .ref()
                                  .child("${user!.email}/image.jpg")
                                  .putFile(file);
                              var downloadURL =
                                  await snapshot.ref.getDownloadURL();
                              await userData.update({'imageURL': downloadURL});
                            }
                          },
                          icon: const Icon(Icons.camera_alt, size: 23),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              nameBox = Row(
                children: [
                  const Text(
                    "İsim:",
                    style: TextStyle(fontFamily: "NotoSansBold", fontSize: 17),
                  ),
                  const SizedBox(
                    width: 33,
                  ),
                  Container(
                    height: 40,
                    width: 225,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(3)),
                    child: Align(
                      alignment: const Alignment(-0.9, 0),
                      child: Text(
                        name,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ),
                  ),
                ],
              );
              classBox = Row(
                children: [
                  const Text(
                    "Bölüm:",
                    style: TextStyle(fontFamily: "NotoSansBold", fontSize: 17),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 40,
                    width: 225,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(3)),
                    // color: Colors.grey,
                    child: Align(
                      alignment: const Alignment(-0.9, 0),
                      child: Text(
                        class_,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ),
                  ),
                ],
              );
              iconBox = Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(imageURL),
                        backgroundColor: Colors.transparent,
                      ),
                    ],
                  ),
                ],
              );
              iconButton = Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 340),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            swap = !swap;
                          });
                        },
                        icon: const Icon(Icons.edit)),
                  ),
                ],
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Column(
                      children: [iconButton],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 100),
                    ),
                    Row(
                      children: [iconBox],
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
                      children: const [
                        SizedBox(
                          height: 15,
                          width: 250,
                        ),
                      ],
                    ),
                    Row(
                      children: [classBox, classEditIcon],
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          height: 10,
                          width: 250,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
