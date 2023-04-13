import 'package:flutter/material.dart';
import 'package:flutterine/utils/constants.dart';

const appBarHeaderTextStyle = TextStyle(
    color: colorWhite,
    fontSize: 20,
    letterSpacing: 1,
    fontWeight: FontWeight.w900);

const appBarDialogHeaderTextStyle = TextStyle(
    color: colorMenuheader,
    fontSize: 20,
    letterSpacing: 1,
    fontWeight: FontWeight.w900);

const appBarHeaderBorderDecoration = BoxDecoration(
  border: Border(bottom: BorderSide(width: 3, color: colorMenuHeaderBorder)),
);

const containerBoxShadow = BoxShadow(
  offset: Offset(0, 1),
  color: colorBlack12,
  blurRadius: 0.5,
);

const containerBorderRadiusAll = BorderRadius.all(Radius.circular(6.0));

const containerBorderRadiusAll12 = BorderRadius.all(Radius.circular(12.0));

const linearGradientSave =
    LinearGradient(stops: [0.02, 0], colors: [colorButton, colorWhite]);
const linearGradientMobileSave =
    LinearGradient(stops: [0.02, 0], colors: [colorButton, colorWhite]);

const containerBoxDecorationSave = BoxDecoration(
    gradient: linearGradientSave,
    borderRadius: containerBorderRadiusAll12,
    color: colorWhite,
    boxShadow: [containerBoxShadow]);

const containerBoxDecorationMobileSave = BoxDecoration(
    gradient: linearGradientMobileSave,
    borderRadius: containerBorderRadiusAll12,
    color: colorWhite,
    boxShadow: [containerBoxShadow]);
