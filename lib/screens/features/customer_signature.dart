import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterine/utils/constants.dart';
import 'package:flutterine/utils/signature.dart';
import 'package:flutterine/utils/responsive.dart';
import 'package:flutterine/utils/shared.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomerSignature extends StatefulWidget {
  const CustomerSignature({super.key});

  @override
  CustomerSignatureState createState() => CustomerSignatureState();
}

class CustomerSignatureState extends State<CustomerSignature> {
  File? _valCustomerSignature;

  @override
  Widget build(BuildContext context) {
    double dblwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: colorPageBackground,
        appBar: appBar(context, "Signature", 15, <Widget>[]),
        body: _valCustomerSignature == null
            ? GestureDetector(
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _getCustomerSignature();
                  setState(() {});
                },
                child: Center(
                    child: Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  color: colorPageBackground,
                  height: 70,
                  child: Container(
                      decoration: const BoxDecoration(
                          color: colorAddBox,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: colorButton),
                            padding: const EdgeInsets.all(2),
                            child: const Icon(
                              FontAwesomeIcons.pen,
                              color: colorWhite,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          const Text('Signature'),
                        ],
                      ))),
                )))
            : Center(
                child: Container(
                padding: const EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Container(
                    decoration: const BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: dblwidth * 0.8,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          alignment: Alignment.center,
                          child: Image.file(_valCustomerSignature!,
                              fit: BoxFit.fitHeight),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        GestureDetector(
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              setState(() {
                                _valCustomerSignature = null;
                              });
                            },
                            child: Center(
                                child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    alignment: WrapAlignment.center,
                                    children: [
                                  miniIcon(Icons.delete_outline_outlined,
                                      colorBlack38,
                                      iconSize: 32),
                                  const Text(
                                    "Delete",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: colorBlack38, fontSize: 16),
                                  )
                                ]))),
                        const SizedBox(
                          height: 12.0,
                        ),
                      ],
                    ))),
              )));
  }

  _getCustomerSignature() async {
    FocusScope.of(context).requestFocus(FocusNode());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: colorTransparent,
          titleTextStyle: const TextStyle(color: colorLabel),
          titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          title: _headingText("Customer Signature"),
          contentPadding: const EdgeInsets.all(0),
          content: SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              height: 520,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 30,
                        height: 350,
                        child: const Signature(
                            appBarColor: colorButton,
                            bottomBarColor: colorButton,
                            isDrawing: true,
                            strTitle: "Customer Signature"))
                  ])),
          actions: const [],
        );
      },
    ).then((geteditimage) {
      if (geteditimage != null) {
        setState(() {
          dynamic image = geteditimage;
          _valCustomerSignature = image;
        });
      }
    }).catchError((er) {});
  }

  Widget _headingText(String strText) {
    double dblwidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 50, 0),
        width: dblwidth * 0.85,
        decoration: BoxDecoration(
            border: Border.all(color: colorWhite),
            color: colorWhite,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: Container(
          padding: EdgeInsets.fromLTRB(isMobile ? 20 : 40, 0, 0, 8),
          width: dblwidth * 0.85,
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 2, color: colorHeadingUnderline))),
          child: Text(
            strText,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
