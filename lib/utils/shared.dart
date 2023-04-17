import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterine/utils/constants.dart';
import 'package:flutterine/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';

PreferredSizeWidget appBar(BuildContext context, String strTitle,
    double dblfontSize, List<Widget> actions,
    {bool autoImplyLeading = true}) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(46),
      child: AppBar(
          title: appBarHeaderTitle(strTitle),
          actions: actions,
          automaticallyImplyLeading: autoImplyLeading,
          leading: autoImplyLeading
              ? IconButton(
                  icon: const Icon(
                    Icons.chevron_left_rounded,
                    size: 32,
                  ),
                  onPressed: () => Navigator.of(context).pop())
              : null));
}

PreferredSizeWidget appBarForDashboard(Widget? leadingAction, String strTitle,
    BuildContext context, List<Widget> actions) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(46.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: leadingAction,
        centerTitle: true,
        title: appBarHeaderTitle(strTitle),
        actions: actions,
      ));
}

Widget appBarHeaderTitle(String strTitle) {
  return Container(
      padding: const EdgeInsets.all(10),
      decoration: appBarHeaderBorderDecoration,
      child: Text(strTitle.toUpperCase(),
          textAlign: TextAlign.center, style: appBarHeaderTextStyle));
}

Widget addhorizontalSpacing(double width) {
  return SizedBox(
    width: width,
  );
}

Widget addVerticalSpacing(double height) {
  return SizedBox(
    height: height,
  );
}

String convertToDateTime(String strText, String format) {
  var dateFormatter = DateFormat(format);
  return (strText) != ""
      ? dateFormatter.format(DateTime.parse(strText).toLocal()).toString()
      : "";
}

Widget addLineWithMargin(double dblHeight, double dblWidth, bool isMobile) {
  return Container(
    margin: EdgeInsets.fromLTRB(isMobile ? 20 : 40, 0, 0, 0),
    height: dblHeight,
    width: dblWidth - (isMobile ? 20 : 40),
    decoration: BoxDecoration(border: Border.all(color: colorLines)),
  );
}

bool isImage(String path) {
  final mimeType = lookupMimeType(path);

  return (mimeType ?? "").startsWith('image/');
}

bool isPDFDocument(String path) {
  final mimeType = lookupMimeType(path);

  return mimeType == 'application/pdf';
}

Widget miniIcon(IconData icon, Color iconColor,
    {double iconSize = 27,
    bool addBorder = false,
    Color borderColor = colorBlack38}) {
  return Container(
    padding: const EdgeInsets.all(5),
    decoration: addBorder
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 1, color: borderColor))
        : null,
    child: Icon(
      icon,
      color: iconColor,
      size: iconSize,
    ),
  );
}

InputDecoration inputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      width: 1.25,
      color: colorTextFieldBorder,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      width: 1.25,
      color: colorTextFieldBorderFocused,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      width: 1.25,
      color: colorTextFieldErrorBorder,
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      width: 1.25,
      color: colorTextFieldErrorBorderFocused,
    ),
  ),
  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
);

Widget miniFilledText(
  Color backgroundColor,
  String strText,
) {
  return Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: backgroundColor,
        border: Border.all(color: backgroundColor)),
    child: Center(
      child: Text(strText,
          style: const TextStyle(color: colorButtonText, fontSize: 12)),
    ),
  );
}

String getRandomString(int length) {
  String chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random rnd = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
}
