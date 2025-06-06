import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:smartfoodinsight_app/features/products/qr_overlay.dart';

class ScanPage extends StatefulWidget {
  final void Function(String? barcode) action;
  const ScanPage({super.key, required this.action});

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
      formats: _barcodeFormats, detectionTimeoutMs: 500);

  @override
  void dispose() {
    mobileScannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      onDetect: (barcodeCapture) async {
        final barcode = barcodeCapture.barcodes.firstOrNull;
        if (barcode != null) {
          widget.action(barcode.rawValue);
          dispose();
        }
      },
      controller: mobileScannerController,
      overlayBuilder: (context, constraints) =>
          QRScannerOverlay(overlayColour: Colors.black.withValues(alpha: 0.5)),
    );
  }
}
