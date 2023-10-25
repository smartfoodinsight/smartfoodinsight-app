import 'package:isar/isar.dart';

part 'product_fridge.g.dart';

@collection
class ProductFridge {
  Id? isarId;
  final String name;
  final String? imageFrontUrl;
  final DateTime date;

  ProductFridge(
      {required this.name, required this.imageFrontUrl, required this.date});
}
