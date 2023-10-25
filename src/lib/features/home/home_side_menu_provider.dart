import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/features/features.dart';
import 'package:smartfoodinsight_app/models/models.dart';

part 'home_side_menu_provider.g.dart';

@riverpod
class HomeSideMenuNotifier extends _$HomeSideMenuNotifier {
  @override
  int build() {
    return 0;
  }

  void onDestinationSelected(int value) {
    state = value;
  }
}

@riverpod
List<MenuItem> menuItems(MenuItemsRef ref) {
  final loc = ref.read(appLocalizationsProvider);

  final menuItems = [
    MenuItem(
        title: loc.products,
        page: const ProductsPage(),
        icon: Icons.production_quantity_limits),
    MenuItem(
        title: loc.myFridge, page: const MyFridgePage(), icon: Icons.kitchen),
  ];

  return menuItems;
}
