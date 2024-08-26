import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';
import 'package:smartfoodinsight_app/common/widgets/widgets.dart';
import 'package:smartfoodinsight_app/features/features.dart';

part 'app_router_provider.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final routerListenable = ref.watch(routerListenableProvider.notifier);
  return GoRouter(
      initialLocation: AppSettings.login,
      refreshListenable: routerListenable,
      redirect: routerListenable.redirect,
      routes: [
        GoRoute(
          path: '${AppSettings.addProductMyFridge}:ean',
          builder: (context, state) => AddProductMyFridgePage(
            ean: state.pathParameters['ean'] ?? 'no-id',
          ),
        ),
        GoRoute(
          path: '${AppSettings.productDetails}:ean',
          builder: (context, state) => ProductDetailsPage(
            ean: state.pathParameters['ean'] ?? 'no-id',
          ),
        ),
        GoRoute(
            path: AppSettings.information,
            builder: (context, state) => const InformationPage()),
        GoRoute(
            path: AppSettings.scanfridge,
            builder: (context, state) => ScanPage(
                action: (barcode) => context.pushReplacement(
                    '${AppSettings.addProductMyFridge}$barcode'))),
        GoRoute(
            path: AppSettings.scandetails,
            builder: (context, state) => ScanPage(
                action: (barcode) => context
                    .pushReplacement('${AppSettings.productDetails}$barcode'))),
        GoRoute(
            path: '/home/:page',
            builder: (context, state) {
              final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
              return KeepAlivePage(HomeTabsPage(pageIndex: pageIndex));
            }),
        GoRoute(path: AppSettings.home, redirect: (_, __) => '/home/0'),
        GoRoute(
            path: AppSettings.signup,
            builder: (context, state) => const RegisterPage()),
        GoRoute(
            path: AppSettings.login,
            builder: (context, state) => const LoginPage()),
      ]);
}
