import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterine/utils/constants.dart';
import 'package:flutterine/utils/shared.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({super.key});

  @override
  QRCodeScannerState createState() => QRCodeScannerState();
}

class QRCodeScannerState extends State<QRCodeScanner> {
  bool boolOpenScanner = false;
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    if (controller != null && mounted) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
    return Scaffold(
      backgroundColor: colorPageBackground,
      appBar: appBar(context, "QR Code Scanner", 15, <Widget>[]),
      body: boolOpenScanner
          ? _buildQrView(context)
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                    minWidth: 72,
                    onPressed: () async {
                      setState(() {
                        controller = null;
                        boolOpenScanner = true;
                        result = null;
                      });
                    },
                    color: colorButton,
                    textColor: colorPageBackground,
                    padding: const EdgeInsets.all(20),
                    shape: const CircleBorder(
                        side: BorderSide(color: colorPageBackground)),
                    child: const Icon(
                      Icons.qr_code_scanner_rounded,
                      size: 36,
                    )),
                addVerticalSpacing(20),
                if (result != null)
                  Text(result!.code.toString())
                else
                  const Text('Scan a code'),
              ],
            )),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: colorIcon,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        boolOpenScanner = false;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
