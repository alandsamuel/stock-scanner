import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';

import 'package:stockScanner/Utils/Writer.dart';

class ScanBarcode extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _ScanBarcodeState createState() => new _ScanBarcodeState();
}

class _ScanBarcodeState extends State<ScanBarcode> {
  String _barcode = "";
  Writer fileWriter = new Writer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Barcode'),
      ),
      body: Center(
        child: Text(_barcode),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _barcode = 'Clicked';
          try {
            String _barcode = await BarcodeScanner.scan();
            setState(() {
              this._barcode = _barcode;
            });
            fileWriter.writeFile(newFile);
          } on PlatformException catch (error) {
            if (error.code == BarcodeScanner.CameraAccessDenied) {
              setState(() {
                this._barcode = 'Camera unauthorized';
              });
            } else {
              setState(() {
                this._barcode = 'Error: $error';
              });
            }
          }
        },
        tooltip: 'Increment',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
