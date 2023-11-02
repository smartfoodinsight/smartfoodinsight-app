import 'dart:math';

import 'package:isar/isar.dart';

part 'product_fridge.g.dart';

@collection
class ProductFridge {
  Id? isarId;
  int idNotification = Random().nextInt(1000000);
  String? name;
  String? image;
  String? date;

  ProductFridge({this.name, this.image, this.date});
}
