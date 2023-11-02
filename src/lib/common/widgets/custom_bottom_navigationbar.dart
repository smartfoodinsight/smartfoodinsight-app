import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartfoodinsight_app/common/extensions/extensions.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        elevation: 0,
        onTap: (value) => onNavigation(context, value),
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: context.loc.pricesProducts),
          BottomNavigationBarItem(
              icon: const Icon(Icons.production_quantity_limits),
              label: context.loc.products),
          BottomNavigationBarItem(
              icon: const Icon(Icons.kitchen), label: context.loc.myFridge),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person), label: context.loc.myProfile),
        ]);
  }

  void onNavigation(BuildContext context, int value) {
    context.go('/home/$value');
  }
}
