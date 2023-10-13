import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartfoodinsight_app/services/services.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  final String ean;
  const ProductDetailsPage({required this.ean, super.key});

  @override
  ProductDetailsPageState createState() => ProductDetailsPageState();
}

class ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  @override
  void initState() async {
    super.initState();

    OpenFoodFactsApiService open = OpenFoodFactsApiService();
    final asa = await open.getProduct(widget.ean);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Detalle')),
        body: Padding(
            padding: const EdgeInsets.all(16), child: Text(widget.ean)));
  }
}
