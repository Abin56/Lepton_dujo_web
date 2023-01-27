import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../meeting_screens/start_meeting.dart';
import '../widgets/button_Container.dart';

// ignore: must_be_immutable
class RoomIDandPassWord extends StatelessWidget {
  String facultyId;
  String password;
  String roomId;
  var course;
  var username;
  bool onpressed;
  String id;
  TextEditingController idContoller = TextEditingController();

  TextEditingController passwordContoller = TextEditingController();
  RoomIDandPassWord(
      {required this.onpressed,
      required this.facultyId,
      required this.id,
      required this.roomId,
      required this.password,
      required this.course,
      required this.username,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: idContoller,
              decoration: InputDecoration(
                  hintText: "Enter your ID",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordContoller,
              decoration: InputDecoration(
                  hintText: "Enter your password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                // Get.to(NewWaitingRoomScreen(
                //   id: id,
                // ));

                if (idContoller.text.trim() == facultyId &&
                    passwordContoller.text.trim() == password) {
                  Get.to(NewWaitingRoomScreen(
                    course: course,
                    username: username,
                    roomid: roomId,
                    id: id,
                  )
                  
                  );
                } else {
                  Get.snackbar("Alert", '',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      messageText: Text(
                        'Wrong Password',
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ));
                }
              },
              child: ButtonContainerWidget(
                curving: 30,
                colorindex: 0,
                height: 60,
                width: 200,
                child: const Center(
                  child: Text(
                    "Enter",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
