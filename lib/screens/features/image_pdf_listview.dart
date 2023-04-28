import 'dart:convert';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterine/utils/constants.dart';
import 'package:flutterine/utils/shared.dart';
import 'package:photo_view/photo_view.dart';

class ImagePDFListview extends StatefulWidget {
  final int intIndex;
  const ImagePDFListview({super.key, required this.intIndex});

  @override
  ImagePDFListviewState createState() => ImagePDFListviewState();
}

class ImagePDFListviewState extends State<ImagePDFListview> {
  int intSelectedIndex = 0;
  bool isLoading = true;
  PDFDocument? document;

  List<String> filePaths = [];

  @override
  void initState() {
    super.initState();
    _initFiles();
  }

  setIndex() {}

  Future _initFiles() async {
    final Map<String, dynamic> assets =
        jsonDecode(await rootBundle.loadString('AssetManifest.json'));

    setState(() {
      filePaths = assets.keys
          .where((String key) => key.contains('ImagePDFListview/'))
          .toList();
    });
    setState(() {
      intSelectedIndex = widget.intIndex;

      loadDocument(intSelectedIndex);
      isLoading = false;
    });
  }

  loadDocument(int intIndex) async {
    if (isPDFDocument(filePaths[intIndex])) {
      document = await PDFDocument.fromAsset(filePaths[intIndex]);
      setState(() {
        isLoading = false;
      });
    } else {
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final PageController controller =
        PageController(initialPage: 0, keepPage: false);
    Size contextSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: colorPageBackground,
        appBar: appBar(context, "Image, PDF Listview", 15, <Widget>[]),
        body: Column(children: <Widget>[
          Flexible(
              child: PageView.builder(
                  clipBehavior: Clip.antiAlias,
                  physics: const BouncingScrollPhysics(),
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (newIndex) {
                    setState(() {
                      intSelectedIndex = newIndex;
                      isLoading = true;
                      loadDocument(intSelectedIndex);
                    });
                  },
                  itemCount: filePaths.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(children: [
                      isLoading
                          ? const Center(
                              child:
                                  CircularProgressIndicator(color: colorButton),
                            )
                          : SizedBox(
                              width: contextSize.width,
                              height: contextSize.height,
                              child: isImage(filePaths[intSelectedIndex])
                                  ? PhotoView(
                                      backgroundDecoration: const BoxDecoration(
                                          color: colorPageSimpleCodeTech),
                                      imageProvider: Image.asset(
                                              filePaths[intSelectedIndex])
                                          .image)
                                  : isPDFDocument(
                                              filePaths[intSelectedIndex]) &&
                                          document != null
                                      ? PDFViewer(
                                          indicatorText:
                                              colorPageSimpleCodeTech,
                                          indicatorBackground: colorIcon,
                                          scrollDirection: Axis.vertical,
                                          progressIndicator: const Center(
                                            child: CircularProgressIndicator(
                                                color: colorButton),
                                          ),
                                          showPicker: false,
                                          document: document!,
                                          showNavigation: false,
                                          enableSwipeNavigation: true,
                                        )
                                      : Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const <Widget>[
                                                Text(
                                                  'Invalid File',
                                                  style: TextStyle(
                                                    fontSize: 21,
                                                    color: colorButton,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                            ),
                      Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            filePaths[intSelectedIndex],
                            style: const TextStyle(
                              color: colorWhite,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ))
                    ]);
                  }))
        ]));
  }
}
