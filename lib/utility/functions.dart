import 'package:flexiares/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));


}

String? validateField(String? value, String field) {
  if (value == null || value.isEmpty) {
    return 'Please enter your $field';
  }
  return null;
}

String? validateMobileField(String? value, String field) {
  if (value == null || value.isEmpty) {
    return 'Please enter your $field';
  }
  if(value.length!=10){
    return 'Please enter valid mobile number';
  }
  return null;
}

Future<String> qrdata() async {
  String qrCodeData = '';
  try {
    qrCodeData = await FlutterBarcodeScanner.scanBarcode(
        "green", "Cancel", true, ScanMode.QR);
  } on PlatformException catch (e) {

  } on FormatException {
    print('null (User returned using the "back"-button before scanning anything. Result)');
  } catch (e) {
    print('Unknown error: $e');
  }

  return qrCodeData;
}

