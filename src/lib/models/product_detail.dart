import 'package:isar/isar.dart';

part 'product_detail.g.dart';

@collection
class ProductDetail {
  Id? isarId;

  final String barCode;
  final String name;
  final String quantity;
  final String nutrimentDataPer;
  final String nutriscore;
  final String novaGroup;
  final String ecoscoreGrade;
  final String kCal;
  final String fats;
  final String saturatedFats;
  final String carbohydrates;
  final String sugars;
  final String fiber;
  final String proteins;
  final String salt;
  final String? imageFrontUrl;

  ProductDetail(
      {required this.barCode,
      required this.imageFrontUrl,
      required this.name,
      required this.quantity,
      required this.nutrimentDataPer,
      required this.nutriscore,
      required this.novaGroup,
      required this.ecoscoreGrade,
      required this.kCal,
      required this.fats,
      required this.saturatedFats,
      required this.carbohydrates,
      required this.sugars,
      required this.fiber,
      required this.proteins,
      required this.salt});
}
