import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart' as app_settings;

import 'package:smartfoodinsight_app/common/extensions/extensions.dart';
import 'package:smartfoodinsight_app/common/widgets/widgets.dart';
import 'package:smartfoodinsight_app/features/features.dart';
import 'package:smartfoodinsight_app/services/services.dart';

class HomeTabsPage extends StatefulWidget {
  final int pageIndex;

  const HomeTabsPage({super.key, required this.pageIndex});

  @override
  State<HomeTabsPage> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabsPage> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(keepPage: true);
    checkStatus();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final pages = const <Widget>[
    KeepAlivePage(PriceComparisonPage()),
    KeepAlivePage(ProductsPage()),
    KeepAlivePage(MyFridgePage()),
    KeepAlivePage(ProfilePage()),
  ];

  @override
  Widget build(BuildContext context) {
    if (pageController.hasClients) {
      pageController.jumpToPage(widget.pageIndex);
    }

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SafeArea(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: pages,
          ),
        ),
        bottomNavigationBar:
            CustomBottomNavigationBar(currentIndex: widget.pageIndex),
      ),
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
