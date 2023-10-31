import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart' as app_settings;

import 'package:smartfoodinsight_app/common/extensions/extensions.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';
import 'package:smartfoodinsight_app/common/widgets/widgets.dart';
import 'package:smartfoodinsight_app/services/services.dart';

class HomeSideMenu extends ConsumerStatefulWidget {
  const HomeSideMenu({super.key});

  @override
  HomeSideMenuState createState() => HomeSideMenuState();
}

class HomeSideMenuState extends ConsumerState<HomeSideMenu> {
  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(homeSideMenuNotifierProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);
    final homeSideMenuNotifier =
        ref.read(homeSideMenuNotifierProvider.notifier);
    final menuItems = ref.read(menuItemsProvider);

    final hasNotch = MediaQuery.viewPaddingOf(context).top > 35;
    return Scaffold(
      appBar: AppBar(title: Text(menuItems[selectedIndex].title)),
      drawer: NavigationDrawer(
          elevation: 1,
          selectedIndex: selectedIndex,
          onDestinationSelected: (value) => {
                homeSideMenuNotifier.onDestinationSelected(value),
                context.pop()
              },
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(29, hasNotch ? 16 : 20, 16, 10),
                child: const Text(AppSettings.appName)),
            const Divider(),
            ...menuItems
                .map((item) => NavigationDrawerDestination(
                    icon: Icon(item.icon), label: Text(item.title)))
                .toList(),
            const Divider(),
            Padding(
                padding: EdgeInsets.fromLTRB(29, hasNotch ? 16 : 20, 16, 10),
                child: GeneralElevatedButton(
                    onPressed: () async => authNotifier.logoutAsync(),
                    child: Text(context.loc.logout))),
          ]),
      body: menuItems[selectedIndex].page,
    );
  }

  void checkStatus() {
    LocalNotificationsService()
        .requestNotificationPermissionsAsync()
        .then((status) {
      if (status.isPermanentlyDenied) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(context.loc.notificationPermission),
            content: Text(context.loc.enableNotificationPermission),
            actions: [
              TextButton(
                child: Text(context.loc.openConfiguration),
                onPressed: () {
                  app_settings.AppSettings.openAppSettings(
                      type: app_settings.AppSettingsType.notification);
                  context.pop();
                },
              ),
            ],
          ),
        );
      }
    });
  }
}
