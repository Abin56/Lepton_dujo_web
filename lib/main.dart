import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:letopn_dujo_web/popular_courses/csir_course.dart';
import 'package:letopn_dujo_web/privacy_ploicy.dart';
import 'package:letopn_dujo_web/screens/industry_integrated.dart';
import 'package:letopn_dujo_web/student_screens/create_student_profile.dart';
import 'package:letopn_dujo_web/terms_condtion.dart';
import 'package:letopn_dujo_web/widgets/white_board.dart';
import 'Login_signup/Register_Page.dart';
import 'Login_signup/reset_page.dart';
import 'Login_signup/student_login_page.dart';
import 'admin/admin_rec_courses.dart';
import 'faculty_screens/create_facluty_profile.dart';
import 'faculty_screens/faculty_action_screen.dart';
import 'faculty_screens/faculty_profile_screen.dart';
import 'login/sign_in_screen.dart';
import 'main_screens/home_screen.dart';
import 'meeting_screens/student_meeting_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDTiohVbMiY40PuQN8PKymvHOXXBYXbRgc",
          authDomain: "lepton-dujo-application-3d591.firebaseapp.com",
          databaseURL:
              "https://lepton-dujo-application-3d591-default-rtdb.asia-southeast1.firebasedatabase.app",
          projectId: "lepton-dujo-application-3d591",
          storageBucket: "lepton-dujo-application-3d591.appspot.com",
          messagingSenderId: "403905720628",
          appId: "1:403905720628:web:da07cd7e558ec54ba97561",
          measurementId: "G-2YZZD5C56J"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
        title: 'Lepton',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/studentlogin': (context) => StudentLoginPage(),
          '/home': (context) => const HomeScreen(),
          // '/signin': (context) => StartMeeting(),
          '/student_journey': (context) => StudentMeetingScreen(),
          '/faculty_journey': (context) => const FacultyActionScreen(),
          // '/video_call': (context) => const VideoCallScreen(),
          '/create_faculty_profile': (context) => FacultyHomePage(),
          '/create_student_profile': (context) => CreateStudentProfile(),
          '/register_page': (context) => RegisterPage(),
          '/csir_course_page': (context) => CsirCourse(),
          '/industry_page': (context) => IndustryIntegrated(),
          // '/start_meeting': (context) => StartMeeting(),
          '/privacy_policy': (context) => PrivacyPolicy(),
          '/terms_condition': (context) => TermsCondition(),
          '/landing_screen': (context) => Login(),
          '/reset': (context) => ResetPage(),
          '/faculty_landing': (context) => const FacultyProfileScreen(),
          '/whiteboard': (context) => const WhiteBoard(),
          '/adminrecordedcourses': (context) => const AdminRecCourses(),
        },
        home: HomeScreen());
  }
}
