import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CourseList {
  final String key;
  final String value;

  CourseList(this.key, this.value);
}

class ShowCourses extends StatefulWidget {
  const ShowCourses({Key? key}) : super(key: key);

  @override
  State<ShowCourses> createState() => _ShowCoursesState();
}

class _ShowCoursesState extends State<ShowCourses> {
  final _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final courseNameInput = TextEditingController();
  final courseCodeInput = TextEditingController();
  final absInput = TextEditingController();
  final maxInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference data = _firestore.collection('brews');
    var userData = data.doc('${user!.email}');

    return Scaffold(
        body: Center(
            child: Column(children: [
      StreamBuilder<DocumentSnapshot>(
          stream: userData.snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.active) {
              var list = snapshot.data.data();
              var courses = list['courses'];
              return Column(
                children: [
                  SizedBox(
                    height: 300,
                    width: 400,
                    child: ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        if (courses.length == 0) {
                          return Container();
                        } else {
                          return Card(
                            child: ListTile(
                              onTap: () async {
                                var result = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          "Düzenle",
                                          style: TextStyle(
                                              fontFamily: "NotoSansBold"),
                                        ),
                                        actions: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 250,
                                                child: TextFormField(
                                                  controller: absInput,
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText:
                                                        "Mevcut Devamsızlık",
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                width: 250,
                                                child: TextFormField(
                                                  controller: maxInput,
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText:
                                                          "Maksimum Devamsızlık"),
                                                ),
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, 'false');
                                                  },
                                                  child: const Text(
                                                    "İptal",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "NotoSansBold",
                                                      color: Colors.red,
                                                    ),
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, 'true');
                                                  },
                                                  child: const Text(
                                                    "Kaydet",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "NotoSansBold",
                                                      color: Colors.red,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      );
                                    });
                                if (result == "true") {
                                  courses[index]['max'] = maxInput.text;
                                  courses[index]['abs'] = absInput.text;
                                  await userData.update({'courses': courses});
                                }
                              },
                              title: Text(
                                  '${courses[index]["courseName"]} (${courses[index]["courseCode"]})'),
                              subtitle: Text(
                                  'Devamsızlık : ${courses[index]["abs"]}/${courses[index]["max"]}'),
                              trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    var result = await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                              "Uyarı",
                                              style: TextStyle(
                                                  fontFamily: "NotoSansBold"),
                                            ),
                                            content: const Text(
                                                "Kaydı silmek istediğine emin misin?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, 'false');
                                                  },
                                                  child: const Text(
                                                    "Hayır",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "NotoSansBold",
                                                        color: Colors.red),
                                                  )),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context, 'true');
                                                },
                                                child: const Text(
                                                  "Evet",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          "NotoSansBold",
                                                      color: Colors.red),
                                                ),
                                              )
                                            ],
                                          );
                                        });
                                    if (result == 'true') {
                                      courses.remove(courses[index]);
                                      await userData
                                          .update({'courses': courses});
                                    }
                                  }),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 350, left: 300),
                      child: FloatingActionButton(
                        onPressed: () async {
                          var result = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    "Ders Kayıt",
                                    style:
                                        TextStyle(fontFamily: "NotoSansBold"),
                                  ),
                                  actions: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 250,
                                          child: TextFormField(
                                            controller: courseNameInput,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: "Ders İsmi",
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 250,
                                          child: TextFormField(
                                            controller: courseCodeInput,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: "Ders Kodu",
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 250,
                                          child: TextFormField(
                                            controller: absInput,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: "Mevcut Devamsızlık"),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 250,
                                          child: TextFormField(
                                            controller: maxInput,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText:
                                                    "Maksimum Devamsızlık"),
                                          ),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              courseNameInput.clear();
                                              courseCodeInput.clear();
                                              absInput.clear();
                                              maxInput.clear();
                                              Navigator.pop(context, 'false');
                                            },
                                            child: const Text(
                                              "İptal",
                                              style: TextStyle(
                                                fontFamily: "NotoSansBold",
                                                color: Colors.red,
                                              ),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, 'true');
                                            },
                                            child: const Text(
                                              "Ekle",
                                              style: TextStyle(
                                                fontFamily: "NotoSansBold",
                                                color: Colors.red,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ],
                                );
                              });

                          if (result == 'true') {
                            Map<String, dynamic> map = {
                              "courseName": courseNameInput.text,
                              "courseCode": courseCodeInput.text,
                              "abs": absInput.text,
                              "max": maxInput.text,
                            };
                            courses.add(map);
                            courseNameInput.clear();
                            courseCodeInput.clear();
                            absInput.clear();
                            maxInput.clear();
                            await userData.update({'courses': courses});
                          }
                        },
                        backgroundColor: Colors.red,
                        child: const Icon(Icons.add),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          })
    ])));
  }
}
