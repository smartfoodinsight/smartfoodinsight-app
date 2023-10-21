import 'package:flutter/material.dart';

import 'package:smartfoodinsight_app/features/features.dart';

class MenuItem {
  final String title;
  final Widget page;
  final IconData icon;

  MenuItem({required this.title, required this.page, required this.icon});
}

List<MenuItem> menuItems = [
  MenuItem(
      title: 'Shopping List',
      page: const ShoppingListPage(),
      icon: Icons.shopping_cart),
  MenuItem(
      title: 'Products',
      page: const ProductsPage(),
      icon: Icons.production_quantity_limits)
];
