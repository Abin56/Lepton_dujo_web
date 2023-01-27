import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letopn_dujo_web/model/subscribedStudents.dart';
import 'package:letopn_dujo_web/recorded_section/pdf_section.dart';
import 'package:letopn_dujo_web/widgets/button_Container.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class SubRecInvoice extends StatelessWidget {
  String collection_name;
  SubRecInvoice({required this.collection_name, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice Section"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(collection_name)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: 1000,
                        width: 500,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              final data =
                                  RecordedCourseSubScribedUserModel.fromJson(
                                      snapshot.data!.docs[index].data());
                              return GestureDetector(
                                onTap: () {},
                                child: ButtonContainerWidget(
                                    curving: 30,
                                    colorindex: 0,
                                    height: 180,
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
                                                'Name :',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                data.userName,
                                                style: GoogleFonts.montserrat(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'email :',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                data.useremail,
                                                style: GoogleFonts.montserrat(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'course :',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                data.courseName,
                                                style: GoogleFonts.montserrat(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'INVOICE N0 :- ${data.inVoiceNumber}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => InvoiceScreen(
                                                            customerName:
                                                                data.userName,
                                                            email:
                                                                data.useremail,
                                                            inVoiceNumber: data
                                                                .inVoiceNumber,
                                                            price: 100.0,
                                                            purchasingModel: data
                                                                .courseName)),
                                                  );
                                                },
                                                child: ButtonContainerWidget(
                                                  curving: 30,
                                                  colorindex: 4,
                                                  height: 30,
                                                  width: 150,
                                                  child: Center(
                                                    child: Text(
                                                      'Get Invoice',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          collection_name)
                                                      .doc(data.id)
                                                      .delete();
                                                },
                                                child: ButtonContainerWidget(
                                                  curving: 30,
                                                  colorindex: 5,
                                                  height: 30,
                                                  width: 150,
                                                  child: Center(
                                                    child: Text(
                                                      'Delete',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Text(
                                                '',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
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
            ],
          ),
        ),
      )),
    );
  }
}
