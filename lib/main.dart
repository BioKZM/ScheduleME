import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scheduleme/firebase_options.dart';
import 'package:scheduleme/package/settings.dart';
import 'package/Courses/addCourse.dart';
import 'package/StudyPlan/addPlan.dart';
import 'package/planner.dart';
import 'package/login.dart';
import 'package/home.dart';
import 'package/loading.dart';
import 'package/absenteeism.dart';
import 'package/settings.dart';

// void test(BuildContext context) {
//   Navigator.pushNamed(context, "/main");
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: "ScheduleME",
    initialRoute: "/loading",
    routes: {
      "/loading": (context) => const Loading(),
      "/login": (context) => const Login(),
      "/main": (context) => const Main(),
      "/home": (context) => const Home(),
      "/absenteeism": (context) => const Absenteeism(),
      "/planner": (context) => const Planner(),
      "/addCourse": (context) => const AddCourse(),
      "/addPlan": (context) => const AddPlan(),
      "/settings": (context) => const Settings(),
    },
    // routes: {
    //   "/": (context) => Loading(),
    //   "/settings": (context) => Settings(),
    //   "/home": (context) => Home(),
    //   "/courses": (context) => Courses(),
    //   "/groups": (context) => Groups()
    // },
  ));
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  PageController controller = PageController();

  int currentIndex = 0;
  final pages = [
    const Home(),
    const Absenteeism(),
    const Planner(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: SizedBox(
          height: 68,
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.red,
              unselectedItemColor: Colors.black,
              iconSize: 30,
              currentIndex: currentIndex,
              onTap: (index) => setState(
                    () => currentIndex = index,
                  ),
              // onTap: onTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 25,
                  ),
                  label: "Ana Sayfa",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.today_rounded,
                    size: 25,
                  ),
                  label: "Devamsızlık",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.wysiwyg_rounded, size: 25),
                  label: "Planlayıcı",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 25,
                  ),
                  label: "Ayarlar",
                )
              ])),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'home.dart';
// import 'courses.dart';

// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({Key? key}) : super(key: key);

//   @override
//   State<BottomNavBar> createState() => BottomNavBarState();
// }

// class BottomNavBarState extends State<BottomNavBar> {
//   

//   // Navigator.pushNamed(context, "/home");,

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
