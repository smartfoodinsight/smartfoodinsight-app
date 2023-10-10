import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartfoodinsight_app/common/providers/providers.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';
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
            path: AppSettings.home,
            builder: (context, state) => const HomeSideMenu()),
        GoRoute(
            path: AppSettings.signup,
            builder: (context, state) => const RegisterPage()),
        GoRoute(
            path: AppSettings.login,
            builder: (context, state) => const LoginPage()),
        //GoRoute(path: home, builder: (context, state) => const SideMenu()),
      ]);
}
