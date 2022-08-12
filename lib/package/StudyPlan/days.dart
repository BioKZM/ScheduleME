import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../services/database.dart';
import '../../services/user.dart';
import '../Courses/deleteCourse.dart';

class CourseList {
  final String key;
  final String value;

  CourseList(this.key, this.value);
}

class DaysPlan extends StatefulWidget {
  const DaysPlan({Key? key}) : super(key: key);

  @override
  State<DaysPlan> createState() => _DaysPlanState();
}

class _DaysPlanState extends State<DaysPlan> {
  List<String> timeList = [
    "06:00 - 07:00",
    "07:00 - 08:00",
    "08:00 - 09:00",
    "09:00 - 10:00",
    "10:00 - 11:00",
    "11:00 - 12:00",
    "12:00 - 13:00",
    "13:00 - 14:00",
    "14:00 - 15:00",
    "15:00 - 16:00",
    "16:00 - 17:00",
    "17:00 - 18:00",
    "18:00 - 19:00",
    "19:00 - 20:00",
    "20:00 - 21:00",
    "21:00 - 22:00",
    "22:00 - 23:00",
    "23:00 - 00:00",
  ];
  late String data;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as String;
    // print(data);
    final user = Provider.of<FUser>(context);

    TextEditingController controller_ = TextEditingController();

    Future showAlertDialog(BuildContext context) {
      // return showDialog(context: context, builder: (context)
      // {

      // })
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Program Ayarla",
              style: TextStyle(fontFamily: "NotoSansBold"),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(controller: controller_),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  String description = controller_.text;
                  controller_.clear();
                  Navigator.of(context).pop(description);
                },
                child: const Text(
                  "Tamam",
                  style:
                      TextStyle(fontFamily: "NotoSansBold", color: Colors.red),
                ),
              )
            ],
          );
        },
      );
    }

    return StreamBuilder<UserData>(
        stream: DatabaseService(userid: user.userid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error.toString());
            UserData? userData = snapshot.data;
            // Map<String, dynamic>? planList = userData?.plans;
            // print(userData?.plans![data]);
            // List<CourseList>? planList = userData?.plans!.entries
            //     .map((entry) => CourseList(entry.key, entry.value))
            //     .toList();
            // print(userData?.plans!['Pazartesi']['08:00 - 09:00']);
            print(userData?.plans);
            // Map<String, dynamic> liste = userData?.plans![data];
            // var sortedKey = liste.keys.toList()..sort();
            // Map<String,dynamic> daysList = userData?.plans?
            // List<CourseList>? planList = sortedKey
            //     .map((entry) => CourseList(entry.key, entry.value))
            //     .toList();
            // Iterable<CourseList> courseList =
            // sortedKey.map((entry) => CourseList(entry.));
            // .map((entry) => CourseList(entry.key, entry.value))
            // .toList();

            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
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
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                          itemBuilder: (context, index) {
                            // print(index);
                            // final item = planList![index];
                            // final key = sortedKey[index]
                            // print(planList![index]);
                            // print(planList?[index]);
                            // print();

                            return ListTile(
                              // title: Text(sortedKey[index]),
                              // subtitle: Text(planList![data][sortedKey[index]]),
                              trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      showAlertDialog(context)
                                          .then((value) async {
                                        // print(value);
                                        if (value == "") {
                                          String desc = "Plan yok.";
                                          // planList[data][sortedKey[index]] =
                                          desc;
                                        } else {
                                          String desc = value;
                                          // planList[data][sortedKey[index]] =
                                          desc;
                                        }

                                        // planList[data][sortedKey[index]] = desc;
                                        dynamic result =
                                            DatabaseService(userid: user.userid)
                                                .addAndChangeCourse(
                                                    userData?.name,
                                                    userData?.surname,
                                                    userData?.courses,
                                                    userData?.groups,
                                                    userData?.plans);
                                        ;
                                        // Map<String, dynamic> dict = value;
                                        // print(dict.keys.first);
                                        // print(dict.values.first);
                                        // print(courseList);
                                        // Map<String, dynamic>? courses =
                                        //     userData!.courses;

                                        // courses?.remove(item.key);
                                        // courses?[dict.keys.first] =
                                        //     dict.values.first;
                                        // dynamic result =
                                        //     DatabaseService(userid: user.userid)
                                        //         .addAndChangeCourse(
                                        //             userData.name,
                                        //             userData.surname,
                                        //             courses,
                                        //             userData.groups,
                                        //             userData.plans);
                                      });
                                    });
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.blue[600],
                                  )),
                            );
                          },
                          itemCount: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }

          return const Scaffold(
              body: Center(child: SpinKitWave(color: Colors.red, size: 30)));
        });
  }
}
