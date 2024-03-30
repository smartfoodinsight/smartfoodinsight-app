import 'package:smartfoodinsight_app/models/models.dart';

class MyProduct {
  late bool lastPage;
  late List<ProductDetail> products;

  MyProduct({this.lastPage = false, this.products = const []});
}
