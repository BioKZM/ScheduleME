import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../services/database.dart';
import '../../services/user.dart';

class CourseList {
  final String key;
  final String value;

  CourseList(this.key, this.value);
}

class Values {
  final String dersKodu;
  final String dersAdi;

  Values(this.dersKodu, this.dersAdi);
}

class EditCourse extends StatefulWidget {
  const EditCourse({Key? key}) : super(key: key);

  @override
  State<EditCourse> createState() => _EditCourseState();
}

class _EditCourseState extends State<EditCourse> {
  TextEditingController controller_ = TextEditingController();
  TextEditingController controller2_ = TextEditingController();

  Future showAlertDialog(BuildContext context) {
    // return showDialog(context: context, builder: (context)
    // {

    // })
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Ders Düzenle",
            style: TextStyle(fontFamily: "NotoSansBold"),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "Ders Kodu",
                style: TextStyle(fontFamily: "NotoSansLight", fontSize: 17),
              ),
              TextFormField(controller: controller_),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Ders Adı",
                style: TextStyle(fontFamily: "NotoSansLight", fontSize: 17),
              ),
              TextFormField(controller: controller2_),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Map<String, dynamic>? dict = {
                  controller_.text: controller2_.text
                };
                controller_.clear();
                controller2_.clear();

                // Values(dersKodu: controller_.text, dersAdi: controller2_.text);
                Navigator.of(context).pop(dict);
              },
              child: const Text(
                "Tamam",
                style: TextStyle(fontFamily: "NotoSansBold", color: Colors.red),
              ),
            )
          ],
        );

        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return alertDialog;
        //     });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(userid: user.userid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            List<CourseList>? courseList = userData?.courses?.entries
                .map((entry) => CourseList(entry.key, entry.value))
                .toList();
            print(courseList);

            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_rounded),
                  ),
                  Column(
                    children: [
                      ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemBuilder: (context, index) {
                          final item = courseList![index];

                          return ListTile(
                            title: Text(item.key),
                            subtitle: Text(item.value),
                            trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showAlertDialog(context)
                                        .then((value) async {
                                      Map<String, dynamic> dict = value;
                                      print(dict.keys.first);
                                      print(dict.values.first);
                                      print(courseList);
                                      Map<String, dynamic>? courses =
                                          userData!.courses;

                                      courses?.remove(item.key);
                                      courses?[dict.keys.first] =
                                          dict.values.first;
                                      dynamic result =
                                          DatabaseService(userid: user.userid)
                                              .addAndChangeCourse(
                                                  userData.name,
                                                  userData.surname,
                                                  courses,
                                                  userData.groups,
                                                  userData.plans);
                                    });
                                  });
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue[600],
                                )),
                          );
                        },
                        itemCount: courseList!.length,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }

          return const Scaffold(
              body: Center(child: SpinKitWave(color: Colors.red, size: 30)));
        });
  }
}
