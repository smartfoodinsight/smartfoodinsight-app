import 'package:flutter/material.dart';
import 'package:smartfoodinsight_app/common/app_settings.dart';
import 'package:smartfoodinsight_app/models/models.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int navDrawerIndex = 0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.viewPaddingOf(context).top > 35;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text(menuItems[navDrawerIndex].title)),
      drawer: NavigationDrawer(
          selectedIndex: navDrawerIndex,
          onDestinationSelected: (value) => onDestinationSelected(value),
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(29, hasNotch ? 16 : 20, 16, 10),
                child: const Text(AppSettings.appName)),
            const Divider(),
            ...menuItems.sublist(0, 2).map((item) =>
                NavigationDrawerDestination(
                    icon: Icon(item.icon), label: Text(item.title)))
          ]),
      body: menuItems[navDrawerIndex].page,
    );
  }

  void onDestinationSelected(int value) {
    setState(() {
      navDrawerIndex = value;
    });
    scaffoldKey.currentState?.closeDrawer();
  }
}
