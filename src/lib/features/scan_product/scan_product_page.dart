import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanProductPage extends ConsumerWidget {
  const ScanProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    MobileScannerController mobileScannerController = MobileScannerController();

    return MobileScanner(
      onDetect: (barcodeCapture) => onBarCodeCapture,
      controller: mobileScannerController,
    );
  }

  void onBarCodeCapture(BarcodeCapture barcodeCapture) {
    String aaa = barcodeCapture.raw;
  }
}
