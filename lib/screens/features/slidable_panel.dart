import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterine/utils/constants.dart';
import 'package:flutterine/utils/responsive.dart';
import 'package:flutterine/utils/shared.dart';
import 'package:flutterine/utils/styles.dart';

class SlidablePanel extends StatefulWidget {
  const SlidablePanel({super.key});

  @override
  SlidablePanelState createState() => SlidablePanelState();
}

class SlidablePanelState extends State<SlidablePanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorPageBackground,
        appBar: appBar(context, "Sliding Panel", 15, <Widget>[]),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SlidableAutoCloseBehavior(
                key: Key(getRandomString(5)),
                closeWhenOpened: true,
                closeWhenTapped: false,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return _slidable(index + 1);
                  },
                ))));
  }

  Widget _slidable(int intNumber) {
    return Slidable(
        key: Key(getRandomString(32)),
        closeOnScroll: true,
        endActionPane: ActionPane(
            dragDismissible: true,
            motion: const BehindMotion(),
            extentRatio: 0.30,
            children: [_delete()]),
        child: _slidablePanelTile(intNumber));
  }

  Widget _delete() {
    return GestureDetector(
        onTap: () {},
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
            height: 156,
            width: (MediaQuery.of(context).size.width * 0.29) - 10,
            decoration: const BoxDecoration(
              color: colorLgOrder,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Center(
                child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                  miniIcon(Icons.delete_outline_outlined, colorWhite,
                      iconSize: 32),
                  const Text(
                    "Delete",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colorWhite, fontSize: 16),
                  )
                ])),
          ),
          Container(
              padding: const EdgeInsets.all(5),
              height: 156,
              width: 15,
              decoration: const BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: const Text(""))
        ]));
  }

  Widget _slidablePanelTile(int intNumber) {
    bool isMobile = Responsive.isMobile(context);
    double dblWidth = MediaQuery.of(context).size.width - 20;
    return Stack(children: [
      Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
          width: dblWidth,
          height: 156,
          clipBehavior: Clip.antiAlias,
          decoration: isMobile
              ? containerBoxDecorationDefaultMobile
              : containerBoxDecorationDefault,
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(top: 0),
                        child: const Icon(Icons.sledding_rounded,
                            color: colorButton, size: 0)),
                    addhorizontalSpacing(isMobile ? 30 : 40),
                    Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Sliding Panel $intNumber",
                          style: const TextStyle(
                            color: colorLabel,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                )
              ]))
    ]);
  }
}
