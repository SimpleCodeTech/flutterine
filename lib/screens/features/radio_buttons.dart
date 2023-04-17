import 'package:flutter/material.dart';
import 'package:flutterine/utils/constants.dart';
import 'package:flutterine/utils/responsive.dart';
import 'package:flutterine/utils/shared.dart';

class RadioButtons extends StatefulWidget {
  const RadioButtons({super.key});

  @override
  RadioButtonsState createState() => RadioButtonsState();
}

class RadioButtonsState extends State<RadioButtons> {
  String _valRadioButton = radioButtonNone;
  String _valRadioButton2 = radioButtonNone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorPageBackground,
        appBar: appBar(context, "Radio buttons", 15, <Widget>[]),
        body: Center(
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Wrap(
                  runAlignment: WrapAlignment.center,
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    Container(
                        width: Responsive.isMobile(context)
                            ? MediaQuery.of(context).size.width
                            : MediaQuery.of(context).size.width * 0.75,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: _valRadioButton == radioButtonNone
                                  ? colorTextFieldErrorBorder
                                  : colorTextFieldBorder),
                          borderRadius: BorderRadius.circular(10),
                          color: colorWhite,
                        ),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              children: <Widget>[
                                _getRadioButtons(radioButtonError),
                                _getRadioButtons(radioButtonOrder),
                                _getRadioButtons(radioButtonNote)
                              ],
                            ))),
                    Container(
                        width: Responsive.isMobile(context)
                            ? MediaQuery.of(context).size.width
                            : MediaQuery.of(context).size.width * 0.75,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: _valRadioButton2 == radioButtonNone
                                  ? colorTextFieldErrorBorder
                                  : colorTextFieldBorder),
                          borderRadius: BorderRadius.circular(10),
                          color: colorWhite,
                        ),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              clipBehavior: Clip.antiAlias,
                              runSpacing: 10,
                              spacing: 10,
                              children: <Widget>[
                                _getRadioButtons2("Radio 1"),
                                _getRadioButtons2("Sample 2"),
                                _getRadioButtons2("Value 3"),
                                _getRadioButtons2("Dummy 4"),
                                _getRadioButtons2("Example 5"),
                                _getRadioButtons2("Test 6"),
                                _getRadioButtons2("Radio Value 7"),
                                _getRadioButtons2("Single selection 8"),
                                _getRadioButtons2("Select this value 9"),
                                _getRadioButtons2("Radio Button 10"),
                                _getRadioButtons2("Hello world 11")
                              ],
                            )))
                  ],
                ))));
  }

  Widget _getRadioButtons(String strValue) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
      minWidth: 80,
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());

        if (_valRadioButton != strValue) {
          setState(() {
            _valRadioButton = strValue;
          });
        } else {
          setState(() {
            _valRadioButton = radioButtonNone;
          });
        }
        setState(() {});
      },
      color:
          (_valRadioButton == radioButtonError && strValue == radioButtonError)
              ? colorRed
              : (_valRadioButton == radioButtonOrder &&
                      strValue == radioButtonOrder)
                  ? colorButton
                  : (_valRadioButton == radioButtonNote &&
                          strValue == radioButtonNote
                      ? colorButtonDisabled
                      : colorWhite),
      textColor: (_valRadioButton == strValue ? colorWhite : colorBlack54),
      padding: const EdgeInsets.all(10),
      child: Text(strValue),
    );
  }

  Widget _getRadioButtons2(String strValue) {
    return SizedBox(
        child: MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
      minWidth: 80,
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());

        if (_valRadioButton2 != strValue) {
          setState(() {
            _valRadioButton2 = strValue;
          });
        } else {
          setState(() {
            _valRadioButton2 = radioButtonNone;
          });
        }
        setState(() {});
      },
      color: (_valRadioButton2 == strValue) ? colorButton : colorWhite,
      textColor: (_valRadioButton2 == strValue ? colorWhite : colorBlack54),
      padding: const EdgeInsets.all(10),
      child: Text(strValue),
    ));
  }
}
