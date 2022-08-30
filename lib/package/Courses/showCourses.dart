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
  final absInput = TextEditingController();

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
                        return Card(
                          child: ListTile(
                            title: Text('${courses[index]["courseName"]}'),
                            subtitle:
                                Text('Devamsızlık : ${courses[index]["abs"]}'),
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
                                                Navigator.pop(context, 'true');
                                              },
                                              child: const Text(
                                                "Evet",
                                                style: TextStyle(
                                                    fontFamily: "NotoSansBold",
                                                    color: Colors.red),
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                  if (result == 'true') {
                                    courses.remove(courses[index]);
                                    Map<String, dynamic> veri = {
                                      'name': list['name'],
                                      'surname': list['surname'],
                                      'courses': courses,
                                    };
                                    await userData.set(veri);
                                  }
                                }),
                          ),
                        );
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
                                  // content: const Text(
                                  //     "Kaydı silmek istediğine emin misin?"),
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
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 250,
                                          child: TextFormField(
                                            controller: absInput,
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText:
                                                    "Maksimum devamsızlık"),
                                          ),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, 'false');
                                            },
                                            child: const Text(
                                              "Hayır",
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
                                              "Evet",
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
                              "abs": absInput.text
                            };
                            // courses.remove(courses[index]);
                            courses.add(map);
                            Map<String, dynamic> veri = {
                              'name': list['name'],
                              'surname': list['surname'],
                              'courses': courses,
                            };
                            await userData.set(veri);
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
            // var user = snapshot.connectionState;
            // print(snapshot.connectionState);
            // // var userName = user['name'];
            // return Text('${snapshot.data}');
            // if (snapshot.hasData &&
            //     snapshot.connectionState == ConnectionState.active) {
            //   return Text('${snapshot.data.data()}');
            // } else {
            //   return Text('Yükleniyor');
            // }

            // List<DocumentSnapshot> list = snapshot.data.docs;
            // if (snapshot.hasError) {
            //   return Center(child: Text("Bir hata oluştu"));
            // } else {
            //   if (snapshot.hasData) {
            //     return Flexible(
            //       child: ListView.builder(
            //         itemCount: list.length,
            //         itemBuilder: (context, index) {
            //           return Card(
            //               child: ListTile(
            //                   title: Text(
            //             '${list[index].data()}',
            //           )));
            //         },
            //       ),
            //     );
            //   } else {
            //     return Center(child: CircularProgressIndicator());
            //   }
            // }
            // var recievedData = snapshot.data;
            // return Text('${asnapshot.data.docs}');
            // return Text('${snapshot.data.data()}');
          })
    ])));

    // return const Scaffold(
    //     body: Center(child: SpinKitWave(color: Colors.red, size: 30)));

    // final user = Provider.of<FUser>(context);

    // return StreamBuilder<UserData>(
    //     stream: DatabaseService(userid: user.userid).userData,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasError) {
    //         print(snapshot.error.toString());
    //         UserData? userData = snapshot.data;
    //         List<CourseList>? courseList = userData?.courses?.entries
    //             .map((entry) => CourseList(entry.key, entry.value))
    //             .toList();

    //         return Scaffold(
    //           body: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               IconButton(
    //                 onPressed: () {
    //                   Navigator.pop(context);
    //                 },
    //                 icon: Icon(Icons.arrow_back_rounded),
    //               ),
    //               Column(
    //                 children: [
    //                   ListView.separated(
    //                     scrollDirection: Axis.vertical,
    //                     shrinkWrap: true,
    //                     separatorBuilder: (BuildContext context, int index) =>
    //                         const Divider(),
    //                     itemBuilder: (context, index) {
    //                       final item = courseList![index];

    //                       return ListTile(
    //                         title: Text(item.key),
    //                         subtitle: Text(item.value),
    //                       );
    //                     },
    //                     itemCount: courseList!.length,
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         );
    //       }

    //       return const Scaffold(
    //           body: Center(child: SpinKitWave(color: Colors.red, size: 30)));
    //     });
  }
}
