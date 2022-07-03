import 'package:flutter/material.dart';
import 'courses.dart';

Route pushToCourses() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Courses(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      });
}

Route pushToGroups() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Courses(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      });
}

class Planner extends StatefulWidget {
  const Planner({Key? key}) : super(key: key);

  @override
  State<Planner> createState() => _PlannerState();
}

class _PlannerState extends State<Planner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(pushToCourses()),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 300,
                              height: 105,
                              // color: Colors.red,
                              child: Card(
                                color: const Color.fromARGB(237, 79, 243, 24)
                                    .withOpacity(0.2),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.grey.withOpacity(0.4),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                // elevation: 10,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    const CircleAvatar(
                                      backgroundImage:
                                          AssetImage("assets/qRnt.png"),
                                      radius: 40,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                      height: 1,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const <Widget>[
                                        SizedBox(
                                          width: 0,
                                          height: 8,
                                        ),
                                        Text(
                                          "Dersler",
                                          style: TextStyle(
                                              fontFamily: "KanitExtraLight",
                                              fontSize: 25),
                                        ),
                                        SizedBox(
                                          height: 50,
                                          width: 160,
                                          child: Text(
                                            "Mevcut derslerini ve programlarını düzenle!",
                                            style: TextStyle(
                                                fontFamily: "NotoSansBold",
                                                fontSize: 10),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                      height: 25,
                    ),
                    const SizedBox(
                      width: 150,
                      height: 5,
                      // color: Colors.red,
                      child: Divider(
                        color: Colors.grey,
                        thickness: 2,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                      height: 25,
                    ),
                    GestureDetector(
                      onTap: () => print("qRnt"),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 300,
                              height: 105,
                              // color: Colors.red,
                              child: Card(
                                color: const Color.fromARGB(235, 11, 192, 183)
                                    .withOpacity(0.2),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.grey.withOpacity(0.4),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                // elevation: 10,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    const CircleAvatar(
                                      backgroundImage:
                                          AssetImage("assets/qRnt.png"),
                                      radius: 40,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                      height: 1,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const <Widget>[
                                        SizedBox(
                                          width: 0,
                                          height: 8,
                                        ),
                                        Text(
                                          "Gruplar",
                                          style: TextStyle(
                                              fontFamily: "KanitExtraLight",
                                              fontSize: 25),
                                        ),
                                        SizedBox(
                                          height: 50,
                                          width: 160,
                                          child: Text(
                                            "Grup oluştur ya da gruplara katıl!",
                                            style: TextStyle(
                                                fontFamily: "NotoSansBold",
                                                fontSize: 10),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(),
              ],
            )
          ],
        ));
  }
}
