import 'package:flutter/material.dart';
import 'package:flutterine/screens/features/circular_menu.dart';
import 'package:flutterine/screens/features/customer_signature.dart';
import 'package:flutterine/screens/features/image_pdf_listview.dart';
import 'package:flutterine/screens/features/pdf_file_viewer.dart';
import 'package:flutterine/screens/features/qr_code_scanner.dart';
import 'package:flutterine/screens/features/radio_buttons.dart';
import 'package:flutterine/screens/features/record_play_audio.dart';
import 'package:flutterine/screens/features/rounded_buttons.dart';
import 'package:flutterine/screens/features/slidable_panel.dart';
import 'package:flutterine/screens/features/web_view.dart';
import 'package:flutterine/utils/constants.dart';
import 'package:flutterine/utils/responsive.dart';
import 'package:flutterine/utils/shared.dart';

class Features extends StatefulWidget {
  const Features({super.key});

  @override
  FeaturesState createState() => FeaturesState();
}

class FeaturesState extends State<Features> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPageBackground,
      appBar: appBar(context, "Features", 15, <Widget>[]),
      body: features(),
    );
  }

  Widget _addButton(String strText, IconData iconData, bool boolSettings,
      {bool isDisabled = false}) {
    bool isMobile = Responsive.isMobile(context);
    double dblWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        if (strText == "PDF File Viewer" && !isDisabled) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PDFFileViewer()),
          );
        } else if (strText == "Image, PDF Listview" && !isDisabled) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ImagePDFListview()),
          );
        } else if (strText == "QR code scanner" && !isDisabled) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QRCodeScanner()),
          );
        } else if (strText == "Signature" && !isDisabled) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CustomerSignature()),
          );
        } else if (strText == "Rounded buttons" && !isDisabled) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RoundedButtons()),
          );
        } else if (strText == "Record audio" && !isDisabled) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RecordPlayAudio()),
          );
        } else if (strText == "Slidable panel" && !isDisabled) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SlidablePanel()),
          );
        } else if (strText == "Radio buttons" && !isDisabled) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RadioButtons()),
          );
        } else if (strText == "Web view" && !isDisabled) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WebView()),
          );
        } else if (strText == "Circular menu" && !isDisabled) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CircularMenu()),
          );
        }
      },
      child: Opacity(
          opacity: isDisabled ? 0.5 : 1,
          child: Stack(children: [
            Container(
                width: dblWidth,
                height: 75,
                margin: EdgeInsets.only(
                    left: isMobile ? 11 : 35, right: isMobile ? 11 : 35),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colorWhite,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: colorBlack12,
                      blurRadius: 0.5,
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(isMobile ? 20 : 40, 0, 0, 0),
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(top: 0),
                        child: Icon(iconData, color: colorButton, size: 32)),
                    addhorizontalSpacing(isMobile ? 30 : 40),
                    Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          boolSettings
                              ? strText.toUpperCase()
                              : strText.toUpperCase(),
                          style: const TextStyle(
                            color: colorLabel,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                )),
            Positioned(
                right: isMobile ? 25 : 50,
                top: 25,
                child: const Icon(Icons.keyboard_arrow_right_rounded,
                    size: 25, color: colorButton))
          ])),
    );
  }

  Widget features() {
    bool isMobile = Responsive.isMobile(context);
    return Stack(children: [
      SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
              color: colorPageBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      addVerticalSpacing(20),
                      _addButton('PDF File Viewer',
                          Icons.picture_as_pdf_rounded, false),
                      addVerticalSpacing(20),
                      _addButton('Image, PDF Listview', Icons.view_list_rounded,
                          false),
                      addVerticalSpacing(20),
                      _addButton(
                          'QR code scanner', Icons.qr_code_2_rounded, false),
                      addVerticalSpacing(20),
                      _addButton('Signature', Icons.draw_rounded, false),
                      addVerticalSpacing(20),
                      _addButton(
                          'Rounded buttons', Icons.circle_rounded, false),
                      addVerticalSpacing(20),
                      _addButton('Record audio', Icons.mic_rounded, false),
                      addVerticalSpacing(20),
                      _addButton(
                          'Slidable panel', Icons.sledding_rounded, false),
                      addVerticalSpacing(20),
                      _addButton('Radio buttons', Icons.radio_button_on_rounded,
                          false),
                      addVerticalSpacing(20),
                      _addButton('Web view', Icons.language_rounded, false),
                      addVerticalSpacing(20),
                      _addButton('Circular menu', Icons.menu_rounded, false),
                      addVerticalSpacing(isMobile ? 30 : 100),
                    ],
                  ),
                ],
              ))),
    ]);
  }
}
