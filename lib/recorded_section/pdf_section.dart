import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../widgets/button_Container.dart';

class InvoiceScreen extends StatefulWidget {
  int inVoiceNumber;
  String customerName;
  String email;
  String purchasingModel;
  double price;

  InvoiceScreen(
      {required this.customerName,
      required this.email,
      required this.inVoiceNumber,
      required this.price,
      required this.purchasingModel,
      super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  String listID = '';

  String dateText = "";
  int deliveryCharge = 50;

  String formatCurrentDate(DateTime date) {
    return DateFormat("dd MMMM, yyyy").format(date);
  }

  getCurrentLiveTime() {
    final DateTime timeNow = DateTime.now();
    final String liveDate = formatCurrentDate(timeNow);

    if (this.mounted) {
      setState(() {
        dateText = liveDate;
      });
    }
  }

  creatNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(1000000) + 1000000).toString();
    listID = roomName;
  }

  @override
  void initState() {
    // getInvoice();

    // _counter();

    creatNewMeeting();
    getCurrentLiveTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBar(
          title: Text("Download Invoice"),
        ),
      ),
      body: SafeArea(
          child: Center(
        child: GestureDetector(
          onTap: () async {
            Printing.layoutPdf(
              onLayout: (PdfPageFormat format) {
                return buildPdf(format);
              },
            );
          },
          child: ButtonContainerWidget(
            curving: 30,
            colorindex: 0,
            height: 60,
            width: 200,
            child: Center(
              child: Text(
                "Download Invoice",
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
      )),
    );
  }

  /// This method takes a page format and generates the Pdf file data
  Future<Uint8List> buildPdf(PdfPageFormat format) async {
    double gst = widget.price - (widget.price / 1.18);
    double cgst = (widget.price - (widget.price / 1.18)) / 2;
    double sgst = (widget.price - (widget.price / 1.18)) / 2;
    double igst = widget.price - (widget.price / 1.18);
    // double totalprice = widget.price + gst + sgst + deliveryCharge;
    // Create the Pdf document
    final pw.Document doc = pw.Document();
    final netImage = await networkImage(
        'https://firebasestorage.googleapis.com/v0/b/lepton-Lepton-91560.appspot.com/o/LOGO%2027-10-2022.png?alt=media&token=001a32fa-0297-4067-8572-91a985421276');

    // Add one page with centered text "Hello World"
    doc.addPage(
      pw.Page(
        build: (pw.Context context) {
          var subtotal = widget.price - sgst;
          return pw.Column(children: [
            pw.Row(children: [
              pw.Column(children: [
                pw.Container(
                  child: pw.Image(netImage, height: 180, width: 180),
                ),
                pw.Container(
                  child: pw.Text("Vectorwind Tech Systems Pvt,Ltd,\n"
                      "Door.No. 4/461,2nd floor,suite#151\n"
                      "valamkottil towers,\n"
                      "judgemukku,Thrikkakkara p.o,\n"
                      "kochi-682021,kerala,India"),
                ),
                pw.SizedBox(height: 30),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Container(
                          child: (pw.Text("TO \n\n"
                                  "${widget.customerName}\n\n" +
                              widget.email))),
                    ])
              ]),
              //  pw.Expanded(child: Container(child: ,))
              pw.Spacer(),
              pw.Column(children: [
                pw.Container(
                  child: (pw.Text('INVOICE')),
                ),
                pw.SizedBox(height: 13),
                pw.Text("NO : VSCI" + widget.inVoiceNumber.toString()),
                pw.SizedBox(height: 9),
                pw.Text("Date : " + dateText),
              ]),
            ]),
            pw.SizedBox(height: 100),
            pw.Row(children: [
              pw.Column(children: [
                pw.Text("Item"),
                pw.SizedBox(height: 20),
                pw.Text(widget.purchasingModel),
              ]),
              pw.Spacer(),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Column(children: [
                      pw.Text("Quantity"),
                      pw.SizedBox(height: 20),
                      pw.Text("1"),
                    ]),
                    pw.SizedBox(width: 20),
                    pw.Column(children: [
                      pw.Text("Rate"),
                      pw.SizedBox(height: 20),
                      pw.Text(widget.price.toString()),
                    ]),
                    pw.SizedBox(width: 30),
                    pw.Column(children: [
                      pw.SizedBox(height: 119),
                      pw.Text("Amount"),
                      pw.SizedBox(height: 20),
                      pw.Text("Subtotal : " + subtotal.toStringAsFixed(2)),
                      pw.SizedBox(height: 20),
                      pw.Text("SGST : " + sgst.toStringAsFixed(2)),
                      pw.SizedBox(height: 20),
                      pw.Text("CGST : " + cgst.toStringAsFixed(2)),
                      pw.SizedBox(height: 20),
                      pw.Text("Total " + widget.price.toString()),
                      pw.SizedBox(height: 20),
                    ])
                  ])
            ]),
          ]);
        },
      ),
    );

    // Build and return the final Pdf file data
    return await doc.save();
  }
}
