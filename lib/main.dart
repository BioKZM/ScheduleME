import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduleme/firebase_options.dart';
import 'package:scheduleme/package/Courses/deleteCourse.dart';
import 'package:scheduleme/package/Courses/editCourse.dart';
import 'package:scheduleme/package/StudyPlan/days.dart';
import 'package:scheduleme/package/StudyPlan/showPlans.dart';
import 'package:scheduleme/package/settings.dart';
import 'package:flutter/services.dart';
import 'package:scheduleme/services/auth.dart';
import 'package:scheduleme/services/user.dart';
import 'package/Courses/addCourse.dart';
import 'package/Courses/showCourses.dart';
import 'package/StudyPlan/addPlan.dart';
import 'package/planner.dart';
import 'package/login.dart';
import 'package/home.dart';
import 'package/loading.dart';
import 'package/absenteeism.dart';
import 'package/register.dart';
import 'package/settings.dart';
import 'package/test.dart';
import 'services/brewList.dart';
import 'services/database.dart';

// void main() => runApp(Main());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HomeMain());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
}

class HomeMain extends StatefulWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FUser?>.value(
        initialData: FUser(),
        value: AuthService().user,
        child: MaterialApp(
          onGenerateRoute: (settings) {
            print(settings.name);
            if (settings.name == "/days") {
              final args = settings.arguments;
              print(args);
            }
          },
          title: "ScheduleME",
          initialRoute: "/loading",
          routes: {
            "/loading": (context) => const Loading(),
            "/login": (context) => const Login(),
            "/register": (context) => const Register(),
            "/main": (context) => const Main(),
            "/home": (context) => const Home(),
            "/absenteeism": (context) => const Absenteeism(),
            "/planner": (context) => const Planner(),
            "/addCourse": (context) => const AddCourse(),
            "/editCourse": (context) => const EditCourse(),
            "/deleteCourse": (context) => const DeleteCourse(),
            "/showCourses": (context) => const ShowCourses(),
            // "/showPlans": (context) => const ShowPlans(),
            "/addPlan": (context) => const AddPlan(),
            "/days": (context) => const DaysPlan(),
            "/settings": (context) => const Settings_(),
            "/brewList": (context) => BrewTile(),
            // "/test": (context) => Test(),
          },
          home: const Loading(),
        ));
  }
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
    const Settings_(),
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
