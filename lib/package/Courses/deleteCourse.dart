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

class DeleteCourse extends StatefulWidget {
  const DeleteCourse({Key? key}) : super(key: key);

  @override
  State<DeleteCourse> createState() => _DeleteCourseState();
}

class _DeleteCourseState extends State<DeleteCourse> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(userid: user.userid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            UserData? userData = snapshot.data;
            List<CourseList>? courseList = userData?.courses?.entries
                .map((entry) => CourseList(entry.key, entry.value))
                .toList();

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
                                    courseList.removeAt(index);
                                    Map<String, dynamic> courses = {};
                                    courseList.forEach((element) =>
                                        courses[element.key] = element.value);
                                    dynamic result =
                                        DatabaseService(userid: user.userid)
                                            .addAndChangeCourse(
                                                userData!.name,
                                                userData.surname,
                                                courses,
                                                userData.groups,
                                                userData.plans);
                                  });
                                },
                                icon: Icon(
                                  Icons.delete_outline_rounded,
                                  color: Colors.red,
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

            // courseList?.forEach((CourseList value) => print(value.toString()));
            // coursesList() =>
            //     userData!.courses?.entries.map((e) => e.key, e.value).toList();
            // List? coursesList = userData!.courses?.entries
            //     .map((entry) => (entry.key, entry.value))
            //     .toList();
          }
          // return Text("");
          return const Scaffold(
              body: Center(child: SpinKitWave(color: Colors.red, size: 30)));
          // return Container(
          //   color: Colors.white,
          //   child: IconButton(
          //     icon: Icon(Icons.arrow_back_rounded),
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //   ),
          // );
        });
  }
}
