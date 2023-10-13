import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:smartfoodinsight_app/features/products/qr_overlay.dart';
import 'package:smartfoodinsight_app/common/utils/app_settings.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  static const List<BarcodeFormat> _barcodeFormats = <BarcodeFormat>[
    BarcodeFormat.code39,
    BarcodeFormat.code93,
    BarcodeFormat.code128,
    BarcodeFormat.ean8,
    BarcodeFormat.ean13,
    BarcodeFormat.itf,
    BarcodeFormat.upcA,
    BarcodeFormat.upcE,
  ];

  MobileScannerController mobileScannerController = MobileScannerController(
      formats: _barcodeFormats, detectionSpeed: DetectionSpeed.noDuplicates);

  @override
  void dispose() {
    super.dispose();
    mobileScannerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      onDetect: (barcodeCapture) async {
        final barcode = barcodeCapture.barcodes.firstOrNull;
        if (barcode != null) {
          context.pushReplacement(
              '${AppSettings.productDetails}${barcode.rawValue}');
        }
      },
      controller: mobileScannerController,
      overlay: QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
    );
  }
}
