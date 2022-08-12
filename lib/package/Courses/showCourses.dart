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

class ShowCourses extends StatefulWidget {
  const ShowCourses({Key? key}) : super(key: key);

  @override
  State<ShowCourses> createState() => _ShowCoursesState();
}

class _ShowCoursesState extends State<ShowCourses> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(userid: user.userid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error.toString());
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
