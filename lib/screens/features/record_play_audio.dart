import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterine/utils/audio_player.dart';
import 'package:flutterine/utils/constants.dart';
import 'package:flutterine/utils/record_audio.dart';
import 'package:flutterine/utils/responsive.dart';
import 'package:flutterine/utils/shared.dart';
import 'package:flutterine/utils/styles.dart';
import 'package:just_audio/just_audio.dart' as ap;

class RecordPlayAudio extends StatefulWidget {
  const RecordPlayAudio({super.key});

  @override
  RecordPlayAudioState createState() => RecordPlayAudioState();
}

class RecordPlayAudioState extends State<RecordPlayAudio> {
  File? _valContactlessAudio;
  bool showPlayer = false;
  late ap.AudioSource audioSource;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorPageBackground,
        appBar: appBar(context, "Record Audio", 15, <Widget>[]),
        body: Center(child: _recordAudio()));
  }

  Widget _recordAudio() {
    return GestureDetector(
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          _getContactlessAudio();
          setState(() {});
        },
        child: showPlayer
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colorPage,
                ),
                height: 170.0,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: AudioPlayer(
                    source: audioSource,
                    onDelete: () {
                      setState(() {
                        showPlayer = false;
                        _valContactlessAudio = null;
                      });
                    },
                  ),
                )))
            : Container(
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
                            Icons.mic_rounded,
                            color: colorWhite,
                            size: 24,
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        const Text('Tap to record'),
                      ],
                    ))),
              ));
  }

  _getContactlessAudio() async {
    FocusScope.of(context).requestFocus(FocusNode());
    double dblwidth = MediaQuery.of(context).size.width;
    bool isMobile = Responsive.isMobile(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            elevation: 0,
            backgroundColor: colorTransparent,
            key: Key(getRandomString(5)),
            titleTextStyle: const TextStyle(color: colorLabel),
            titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            title: _headingText("Record Audio"),
            contentPadding: const EdgeInsets.all(0),
            content: SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                height: 520,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                        decoration: BoxDecoration(
                            border: Border.all(color: colorWhite),
                            color: colorPage,
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15))),
                        height: 170.0,
                        width: dblwidth,
                        child: Center(
                          child: showPlayer
                              ? Container(
                                  color: colorTransparent,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: AudioPlayer(
                                    source: audioSource,
                                    onDelete: () {
                                      setState(() => showPlayer = false);
                                    },
                                  ),
                                )
                              : SizedBox(
                                  height: 150.0,
                                  width: dblwidth * 0.8,
                                  child: AudioRecorder(
                                    onStop: (path) {
                                      setState(() {
                                        audioSource =
                                            ap.AudioSource.uri(Uri.parse(path));
                                        showPlayer = true;
                                        _valContactlessAudio =
                                            File.fromUri(Uri.parse(path));
                                      });
                                    },
                                  )),
                        ),
                      ),
                      addVerticalSpacing(30),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.end,
                              alignment: WrapAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showPlayer = false;
                                        _valContactlessAudio = null;
                                      });
                                    },
                                    child: (_valContactlessAudio != null)
                                        ? Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            alignment: WrapAlignment.center,
                                            children: [
                                                miniIcon(
                                                    Icons
                                                        .delete_outline_outlined,
                                                    colorBlack38,
                                                    iconSize: 32),
                                                const Text(
                                                  'Delete',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: colorBlack38,
                                                      fontSize: 16),
                                                )
                                              ])
                                        : Container()),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (_valContactlessAudio != null) {
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      decoration: isMobile
                                          ? containerBoxDecorationMobileSave
                                          : containerBoxDecorationSave.copyWith(
                                              border: Border.all(
                                                  width: 1,
                                                  color: colorBlack12)),
                                      width: isMobile ? dblwidth - 30 : 225,
                                      height: 40,
                                      child: const Text('Save')),
                                ),
                              ]))
                    ])),
            actions: const [],
          );
        });
      },
    ).then((value) {
      setState(() {});
    });
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
