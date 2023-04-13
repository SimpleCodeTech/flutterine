import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutterine/utils/constants.dart';
import 'package:flutterine/utils/shared.dart';

class PDFFileViewer extends StatefulWidget {
  const PDFFileViewer({super.key});

  @override
  PDFFileViewerState createState() => PDFFileViewerState();
}

class PDFFileViewerState extends State<PDFFileViewer> {
  bool isLoading = true;
  late PDFDocument document;

  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromAsset('assets/PDFViewer/pdfFile.pdf');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPageBackground,
      appBar: appBar(context, "PDF File Viewer", 15, <Widget>[]),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: colorButton),
            )
          : PDFViewer(
              indicatorText: colorPageSimpleCodeTech,
              indicatorBackground: colorIcon,
              scrollDirection: Axis.vertical,
              progressIndicator: const Center(
                child: CircularProgressIndicator(color: colorButton),
              ),
              showPicker: false,
              document: document,
              showNavigation: false,
              enableSwipeNavigation: true,
            ),
    );
  }
}
