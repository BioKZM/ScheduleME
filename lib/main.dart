import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:scheduleme/package/Groups/showGroups.dart';
import 'package:scheduleme/package/Groups/searchGroups.dart';
import 'package:scheduleme/package/StudyPlan/Days/daysMonday.dart';
import 'package/Courses/showCourses.dart';
import 'package/StudyPlan/Days/daysFriday.dart';
import 'package/StudyPlan/Days/daysSaturday.dart';
import 'package/StudyPlan/Days/daysSunday.dart';
import 'package/StudyPlan/Days/daysThursday.dart';
import 'package/StudyPlan/Days/daysTuesday.dart';
import 'package/StudyPlan/Days/daysWednesday.dart';
import 'package/StudyPlan/showPlans.dart';
import 'package/Tasks/showTasks.dart';
import 'package/courses.dart';
import 'package/forgotPassword.dart';
import 'package/groups.dart';
import 'package/planner.dart';
import 'package/login.dart';
import 'package/home.dart';
import 'package/loading.dart';
// import 'package/absenteeism.dart';
import 'package/register.dart';
import 'package/settings.dart';
// import 'globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HomeMain());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
}

class Log {
  static bool LoggedIn = true;
}

class HomeMain extends StatefulWidget {
  const HomeMain({Key? key}) : super(key: key);
  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  @override
  Widget build(BuildContext context) {
    // var userEmail;
    return MaterialApp(
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale('en'), Locale('tr')],
      title: "ScheduleME",
      initialRoute: "/loading",
      routes: {
        "/loading": (context) => const Loading(),
        "/login": (context) => const Login(),
        "/register": (context) => const Register(),
        "/main": (context) => const Main(),
        "/home": (context) => const Home(),
        "/courses": (context) => const Courses(),
        "/forgotPassword": (context) => const ForgotPassword(),
        "/planner": (context) => const Planner(),
        "/groups": (context) => const Groups(),
        "/showGroups": (context) => const ShowGroups(),
        "/searchGroups": (context) => const SearchGroups(),
        "/showCourses": (context) => const ShowCourses(),
        "/showPlans": (context) => const ShowPlans(),
        "/showTasks": (context) => const ShowTasks(),
        "/settings": (context) => const Settings_(),
        "/daysMonday": (context) => const daysMonday(),
        "/daysTuesday": (context) => const daysTuesday(),
        "/daysWednesday": (context) => const daysWednesday(),
        "/daysThursday": (context) => const daysThursday(),
        "/daysFriday": (context) => const daysFriday(),
        "/daysSaturday": (context) => const daysSaturday(),
        "/daysSunday": (context) => const daysSunday(),
      },
      home: const Loading(),
    );
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
    const Courses(),
    const Groups(),
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
                  label: "Dersler",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.wysiwyg_rounded,
                    size: 25,
                  ),
                  label: "Gruplar",
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
