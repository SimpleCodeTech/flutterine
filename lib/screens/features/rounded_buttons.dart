import 'package:flutter/material.dart';
import 'package:flutterine/utils/constants.dart';
import 'package:flutterine/utils/shared.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

class RoundedButtons extends StatefulWidget {
  const RoundedButtons({super.key});

  @override
  RoundedButtonsState createState() => RoundedButtonsState();
}

class RoundedButtonsState extends State<RoundedButtons> {
  String strStatus = stringEmpty;
  int intNoMedia = 0;
  int intMediaLength = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorPageBackground,
        appBar: appBar(context, "Rounded Buttons", 15, <Widget>[]),
        body: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              MaterialButton(
                minWidth: 24,
                onPressed: () {
                  setState(() {
                    strStatus = stringOk;
                  });
                },
                color: _color(strStatus, stringOk, "C"),
                textColor: _color(strStatus, stringOk, "T"),
                padding: const EdgeInsets.all(15),
                shape: CircleBorder(
                    side: BorderSide(color: _color(strStatus, stringOk, "B"))),
                child: const Icon(
                  Icons.check,
                ),
              ),
              MaterialButton(
                minWidth: 24,
                onPressed: () async {
                  setState(() {
                    strStatus = stringError;
                  });
                },
                color: _color(strStatus, stringError, "C"),
                textColor: _color(strStatus, stringError, "T"),
                padding: const EdgeInsets.all(15),
                shape: CircleBorder(
                    side:
                        BorderSide(color: _color(strStatus, stringError, "B"))),
                child: const Icon(Icons.close),
              ),
              MaterialButton(
                minWidth: 24,
                onPressed: () {
                  setState(() {
                    strStatus = stringNotRelevant;
                  });
                },
                color: _color(strStatus, stringNotRelevant, "C"),
                textColor: _color(strStatus, stringNotRelevant, "T"),
                padding: const EdgeInsets.all(15),
                shape: CircleBorder(
                    side: BorderSide(
                        color: _color(strStatus, stringNotRelevant, "B"))),
                child: const Icon(
                  Icons.remove_rounded,
                ),
              ),
              Stack(
                children: <Widget>[
                  MaterialButton(
                      minWidth: 24,
                      onPressed: () async {},
                      color: intNoMedia == 0 ? colorAddBox : colorButton,
                      textColor: intNoMedia == 0 ? colorIcon : colorWhite,
                      padding: const EdgeInsets.all(15),
                      shape: CircleBorder(
                          side: BorderSide(
                              color:
                                  intNoMedia == 0 ? colorAddBox : colorButton)),
                      child: intNoMedia == 0
                          ? Shimmer.fromColors(
                              enabled: true,
                              baseColor: colorIcon,
                              highlightColor: colorWhite,
                              child: const Icon(FontAwesomeIcons.image))
                          : Shimmer.fromColors(
                              enabled: true,
                              baseColor: colorWhite,
                              highlightColor: colorIcon,
                              child: const Icon(FontAwesomeIcons.image))),
                  intNoMedia > 1
                      ? Positioned(
                          top: 0.0,
                          right: 0.0,
                          child: miniFilledText(
                              colorHighlight, intNoMedia.toString()))
                      : const Text("")
                ],
              ),
              Stack(
                children: <Widget>[
                  MaterialButton(
                      minWidth: 24,
                      onPressed: () async {},
                      color: intMediaLength == 0 ? colorAddBox : colorButton,
                      textColor: intMediaLength == 0 ? colorIcon : colorWhite,
                      padding: const EdgeInsets.all(15),
                      shape: CircleBorder(
                          side: BorderSide(
                              color: intMediaLength == 0
                                  ? colorAddBox
                                  : colorButton)),
                      child: intMediaLength == 0
                          ? Shimmer.fromColors(
                              enabled: true,
                              baseColor: colorIcon,
                              highlightColor: colorWhite,
                              child: const Icon(FontAwesomeIcons.image))
                          : Shimmer.fromColors(
                              enabled: true,
                              baseColor: colorWhite,
                              highlightColor: colorIcon,
                              child: const Icon(FontAwesomeIcons.image))),
                  intMediaLength > 1
                      ? Positioned(
                          top: 0.0,
                          right: 0.0,
                          child: miniFilledText(
                              colorHighlight, intMediaLength.toString()))
                      : const Text("")
                ],
              ),
            ])));
  }

  Color _color(String strValue, String strType, String strColor) {
    if (strType == stringOk && strColor == 'C') {
      return (strValue) == stringOk ? colorButton : colorAddBox;
    }
    if (strType == stringOk && strColor == 'T') {
      return (strValue) == stringOk ? colorWhite : colorIcon;
    }
    if (strType == stringOk && strColor == 'B') {
      return (strValue) == stringOk ? colorButton : colorChecklistDefault;
    }
    if (strType == stringError && strColor == 'C') {
      return (strValue) == stringError
          ? colorChecklistError
          : colorChecklistDefault;
    }
    if (strType == stringError && strColor == 'T') {
      return (strValue) == stringError ? colorWhite : colorIcon;
    }
    if (strType == stringError && strColor == 'B') {
      return (strValue) == stringError
          ? colorChecklistError
          : colorChecklistDefault;
    }
    if (strType == stringNotRelevant && strColor == 'C') {
      return (strValue) == stringNotRelevant
          ? colorButtonDisabled
          : colorAddBox;
    }
    if (strType == stringNotRelevant && strColor == 'T') {
      return (strValue) == stringNotRelevant ? colorWhite : colorIcon;
    }
    if (strType == stringNotRelevant && strColor == 'B') {
      return (strValue) == stringNotRelevant
          ? colorButtonDisabled
          : colorChecklistDefault;
    }
    return colorButton;
  }
}
