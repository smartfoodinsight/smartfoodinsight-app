import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/common/utils/app_settings.dart';
import 'package:smartfoodinsight_app/common/widgets/widgets.dart';
import 'package:smartfoodinsight_app/models/models.dart';

class HomeSideMenu extends ConsumerStatefulWidget {
  const HomeSideMenu({super.key});

  @override
  HomeSideMenuState createState() => HomeSideMenuState();
}

class HomeSideMenuState extends ConsumerState<HomeSideMenu> {
  int navDrawerIndex = 0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authNotifierProvider.notifier);

    final hasNotch = MediaQuery.viewPaddingOf(context).top > 35;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text(menuItems[navDrawerIndex].title)),
      drawer: NavigationDrawer(
          elevation: 1,
          selectedIndex: navDrawerIndex,
          onDestinationSelected: (value) => onDestinationSelected(value),
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(29, hasNotch ? 16 : 20, 16, 10),
                child: const Text(AppSettings.appName)),
            const Divider(),
            ...menuItems.sublist(0, 2).map((item) =>
                NavigationDrawerDestination(
                    icon: Icon(item.icon), label: Text(item.title))),
            const Divider(),
            Padding(
                padding: EdgeInsets.fromLTRB(29, hasNotch ? 16 : 20, 16, 10),
                child: GeneralElevatedButton(
                    onPressed: () async => authNotifier.logoutAsync(),
                    child: const Text('Cerrar sesión'))),
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
