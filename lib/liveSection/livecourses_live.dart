import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/live_course_addModel.dart';
import '../widgets/button_container.dart';

class LiveCoursesListScreen extends StatelessWidget {
  const LiveCoursesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Courses"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("LiveCourselist")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: 1000,
                    width: 500,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          final data = LiveCourseAddModel.fromJson(
                              snapshot.data!.docs[index].data());
                          return GestureDetector(
                            onTap: () {},
                            child: ButtonContainerWidget(
                                curving: 30,
                                colorindex: 0,
                                height: 230,
                                width: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'CourseName :',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            data.courseTitle,
                                            style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Room ID :',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            data.roomID,
                                            style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Facultie :',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            data.facultyName,
                                            style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Course Fee:',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            data.courseFee,
                                            style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Duration :',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            data.duration.toString(),
                                            style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Course ID :',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            data.courseID,
                                            style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Posted Date :',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            data.postedDate,
                                            style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Posted Time :',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            data.postedTime,
                                            style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Remove this Course :',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              await deleteliveCategory(
                                                  context: context,
                                                  uid: data.id,
                                                  userName: data.facultyName);
                                            },
                                            child: ButtonContainerWidget(
                                              curving: 30,
                                              colorindex: 4,
                                              height: 30,
                                              width: 150,
                                              child: Center(
                                                child: Text(
                                                  'Remove',
                                                  style: GoogleFonts.montserrat(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: snapshot.data!.docs.length),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              }),
        ),
      ),
    );
  }

  Future<dynamic> deleteliveCategory(
      {required context, required uid, required userName}) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Alert"),
          content: const Text(
            "Are You Sure to remove this course ?",
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () async {
                  FirebaseFirestore.instance
                      .collection("LiveCourselist")
                      .doc(uid)
                      .delete()
                      .then((value) => Navigator.pop(context));
                },
                child: const Text("Ok")),
          ],
        );
      },
    );
  }
}
