import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterine/screens/features/image_pdf_listview.dart';
import 'package:flutterine/utils/constants.dart';
import 'package:flutterine/utils/responsive.dart';
import 'package:flutterine/utils/shared.dart';

class PDFThumbnails extends StatefulWidget {
  const PDFThumbnails({super.key});

  @override
  PDFThumbnailsState createState() => PDFThumbnailsState();
}

class PDFThumbnailsState extends State<PDFThumbnails> {
  bool isLoading = true;
  List<String> filePaths = [];

  @override
  void initState() {
    _initFiles();
    super.initState();
  }

  Future _initFiles() async {
    final Map<String, dynamic> assets =
        jsonDecode(await rootBundle.loadString('AssetManifest.json'));

    setState(() {
      filePaths = assets.keys
          .where((String key) => key.contains('ImagePDFListview/'))
          .toList();
      filePaths.sort((a, b) => a.compareTo(b));
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double dblwidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);
    return Scaffold(
        backgroundColor: colorPageBackground,
        appBar: appBar(context, "Thumbnails", 15, <Widget>[]),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: colorButton),
              )
            : GridView.count(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: Responsive.isMobile(context) ? 3 : 6,
                children: List.generate(
                    filePaths.length,
                    (index) => GestureDetector(
                        onTap: () async {
                          final imageScreen = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ImagePDFListview(intIndex: index),
                            ),
                          );
                          setState(() {});
                        },
                        child: Stack(children: [
                          Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              height: (dblwidth / (isMobile ? 3 : 6)) - 2,
                              width: (dblwidth / (isMobile ? 3 : 6)) - 2,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  color: colorTransparent,
                                  border: Border.all(color: colorButton)),
                              child: thumnailFromFile(
                                  filePaths[index],
                                  getMimeType(filePaths[index]),
                                  context,
                                  (dblwidth / (isMobile ? 3 : 6)) - 2))
                        ]))),
              ));
  }
}
