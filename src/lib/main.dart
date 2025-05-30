import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/common/themes/app_theme.dart';
import 'package:smartfoodinsight_app/services/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationsService().initAsync();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRoutes = ref.watch(appRouterProvider);
    final scaffoldMessengerKey = ref.watch(scaffoldMessengerProvider);

    return MaterialApp.router(
      routerConfig: appRoutes,
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().theme(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('es', 'ES'),
        Locale('en'),
      ],
    );
  }
}
