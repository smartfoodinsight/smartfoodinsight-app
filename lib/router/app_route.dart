import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';
import 'package:smartfoodinsight_app/features/features.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(initialLocation: AppSettings.home, routes: [
    GoRoute(
        path: AppSettings.signup,
        builder: (context, state) => const RegisterPage()),
    GoRoute(
        path: AppSettings.home, builder: (context, state) => const LoginPage()),
    //GoRoute(path: home, builder: (context, state) => const SideMenu()),
  ]);
});
