import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutterine/utils/constants.dart';
import 'package:flutterine/utils/responsive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutterine/utils/shared.dart';
import 'package:flutterine/utils/styles.dart';

TextEditingController heightcontroler = TextEditingController();
TextEditingController widthcontroler = TextEditingController();
var width = 1000;
var height = 350;
List<Map> widgetJson = [];
var howmuchwidgetis = 0;

List<Path> _paths = <Path>[];
List<Paint> _paint = <Paint>[];

Path _path = Path();
bool _repaint = false;

double opacity = 1.0;
StrokeCap strokeType = StrokeCap.round;
double strokeWidth = strokeThin;
double eraserStrokeWidth = strokeThin;
Color selectedColor = drawingColorYellow;
bool isEraser = false;

class Signature extends StatefulWidget {
  final Color appBarColor;
  final Color bottomBarColor;
  final bool isDrawing;
  final String strTitle;
  const Signature(
      {Key? key,
      required this.appBarColor,
      required this.bottomBarColor,
      required this.isDrawing,
      required this.strTitle})
      : super(key: key);

  @override
  SignatureState createState() => SignatureState();
}

var slider = 0.0;

class SignatureState extends State<Signature> {
  List<Offset> offsets = [];
  final scaf = GlobalKey<ScaffoldState>();
  var openbottomsheet = false;
  List type = [];
  List aligment = [];

  final GlobalKey globalKey = GlobalKey();
  File? _image;
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void dispose() {
    isEraser = false;
    _paths.clear();
    _paint.clear();
    opacity = 1.0;
    strokeType = StrokeCap.round;
    strokeWidth = strokeThin;
    eraserStrokeWidth = strokeThin;
    selectedColor = drawingColorYellow;

    //timeprediction.cancel();
    widgetJson.clear();
    heightcontroler.clear();
    widthcontroler.clear();
    super.dispose();
  }

  @override
  void initState() {
    //timers();
    isEraser = false;
    _paths.clear();
    _paint.clear();
    opacity = 1.0;
    strokeType = StrokeCap.round;
    strokeWidth = strokeThin;
    eraserStrokeWidth = strokeThin;
    selectedColor = drawingColorYellow;
    type.clear();
    offsets.clear();
    howmuchwidgetis = 0;
    super.initState();
  }

  double flipValue = 0;
  int rotateValue = 0;
  double blurValue = 0;
  double opacityValue = 0;
  Color colorValue = Colors.transparent;

  double hueValue = 0;
  double brightnessValue = 0;
  double saturationValue = 0;
  @override
  Widget build(BuildContext context) {
    double dblwidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);
    return Scaffold(
        backgroundColor: colorTransparent,
        extendBodyBehindAppBar: true,
        key: scaf,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Screenshot(
                controller: screenshotController,
                child: RotatedBox(
                  quarterTurns: rotateValue,
                  child: Container(
                      margin: const EdgeInsets.all(0),
                      color: colorTransparent,
                      width: MediaQuery.of(context).size.width - 30,
                      height: 200,
                      child: RepaintBoundary(
                          key: globalKey,
                          child: Container(
                              color: colorPage,
                              padding: const EdgeInsets.all(0.0),
                              child: GestureDetector(
                                  onPanStart: (DragStartDetails details) =>
                                      panDown(details),
                                  onPanUpdate: (DragUpdateDetails details) =>
                                      panUpdate(details),
                                  onPanEnd: (DragEndDetails details) =>
                                      panEnd(details),
                                  child: CustomPaint(
                                    painter: PathPainter(
                                        paths: _paths,
                                        repaint: _repaint,
                                        paints: _paint),
                                  ))))),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: colorPage,
                      border: Border.all(color: colorPage),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  width: MediaQuery.of(context).size.width - 30,
                  child: GestureDetector(
                      onTap: () {
                        isEraser = false;
                        _paths.clear();
                        _paint.clear();
                        _image = null;
                        widgetJson = [];
                        setState(() {});
                      },
                      child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          children: [
                            miniIcon(
                                Icons.delete_outline_outlined, colorBlack38,
                                iconSize: 32),
                            const Text(
                              "Clear",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: colorBlack38, fontSize: 16),
                            )
                          ]))),
              addVerticalSpacing(30),
              Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      if (_paths.isNotEmpty || _image != null) {
                        isEraser = false;
                        screenshotController
                            .capture(pixelRatio: 1.5)
                            .then((binaryIntList) async {
                          final paths = await getTemporaryDirectory();

                          final file =
                              await File('${paths.path}/${DateTime.now()}.jpg')
                                  .create();
                          file.writeAsBytesSync(binaryIntList!);
                          Navigator.pop(context, file);
                        }).catchError((onError) {
                          //print(onError);
                        });
                      } else {
                        /*ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Enter signature.')));*/
                      }
                    },
                    child: Container(
                        alignment: Alignment.center,
                        decoration: isMobile
                            ? containerBoxDecorationMobileSave
                            : containerBoxDecorationSave.copyWith(
                                border:
                                    Border.all(width: 1, color: colorBlack12)),
                        width: isMobile ? dblwidth - 30 : 225,
                        height: 40,
                        child: const Text('Save')),
                  ))
            ]));
  }

  panDown(DragStartDetails details) {
    setState(() {
      _path = Path();
      _paths.add(_path);
      RenderBox object = context.findRenderObject() as RenderBox;
      Offset localPosition = object.globalToLocal(details.globalPosition);
      _paths.last.moveTo(localPosition.dx - 10, localPosition.dy - 5);
      _paths.last.lineTo(localPosition.dx - 10, localPosition.dy - 5);

      Paint paint = Paint()
        ..color = selectedColor
        ..style = PaintingStyle.stroke
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round
        ..strokeWidth = strokeWidth
        ..isAntiAlias = true;

      Paint paintEraser = Paint()
        ..color = colorTransparent
        ..blendMode = BlendMode.clear
        ..strokeWidth = eraserStrokeWidth
        ..style = PaintingStyle.stroke
        ..isAntiAlias = true;
      isEraser == false ? _paint.add(paint) : _paint.add(paintEraser);

      _repaint = true;
    });
  }

  var fingerPostionY = 0.0, fingerPostionX = 0.0;
  double distanceBetweenTwoPoints(double x1, double y1, double x2, double y2) {
    double x = x1 - x2;
    x = x * x;
    double y = y1 - y2;
    y = y * y;

    double result = x + y;
    return sqrt(result);
  }

  panUpdate(DragUpdateDetails details) {
    RenderBox object = context.findRenderObject() as RenderBox;
    Offset localPosition = object.globalToLocal(details.globalPosition);

    if (fingerPostionY < 1.0) {
      // assigen for the first time to compare
      fingerPostionY = localPosition.dy;
      fingerPostionX = localPosition.dx;
    } else {
      // they use a lot of fingers
      double distance = distanceBetweenTwoPoints(
          localPosition.dx, localPosition.dy, fingerPostionX, fingerPostionY);

      // the distance between two fingers must be above 50
      // to disable multi touch
      if (distance > 50) {
        return;
      }
    }

    // update to use it in comparison
    fingerPostionY = localPosition.dy;
    fingerPostionX = localPosition.dx;

    setState(() {
      _paths.last.lineTo(fingerPostionX - 10.0, fingerPostionY - 5.0);
    });
  }

  panEnd(DragEndDetails details) {
    setState(() {
      fingerPostionY = 0.0;
//      _repaint = true;
    });
  }
}

class PathPainter extends CustomPainter {
  List<Path>? paths;
  List<Paint>? paints;
  bool? repaint;
  int i = 0;
  PathPainter({this.paths, this.repaint, this.paints});
  @override
  void paint(Canvas canvas, Size size) {
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
    for (var path in paths!) {
      canvas.drawPath(path, paints![i]);
      ++i;
    }

    canvas.restore();
    i = 0;
    repaint = false;
  }

  @override
  bool shouldRepaint(PathPainter oldDelegate) => repaint!;
}

class TouchPoints {
  Paint? paint;
  Offset? points;
  TouchPoints({this.points, this.paint});
}
