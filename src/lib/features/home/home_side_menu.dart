import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smartfoodinsight_app/common/extensions/app_localizations_extension.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/common/utils/app_settings.dart';
import 'package:smartfoodinsight_app/common/widgets/widgets.dart';

class HomeSideMenu extends ConsumerWidget {
  const HomeSideMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
}
