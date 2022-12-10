import 'package:flutter/material.dart';

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_rounded)),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/showPlans"),
                    child: SizedBox(
                      width: 150,
                      height: 150,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const <Widget>[
                            Icon(
                              Icons.playlist_add_circle_rounded,
                              size: 40,
                            ),
                            Text(
                              "Çalışma Planı",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/showCourses"),
                    child: SizedBox(
                      width: 150,
                      height: 150,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Icon(
                              Icons.collections_bookmark_rounded,
                              size: 40,
                            ),
                            Text("Dersler"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/showTasks"),
                    child: SizedBox(
                      width: 150,
                      height: 150,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Icon(
                              Icons.collections_bookmark_rounded,
                              size: 40,
                            ),
                            Text("Görevler"),
                          ],
                        ),
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
