import 'package:go_router/go_router.dart';
import 'package:smartfoodinsight_app/features/features.dart';

class Routes {
  static const home = '/';

  static final appRoutes = GoRouter(initialLocation: home, routes: [
    GoRoute(path: home, builder: (context, state) => const SideMenu())
  ]);

  // static const initialRoute = home;

  // static final Map<String, Widget Function(BuildContext)> appRoutes = {
  //   buttons: (BuildContext context) => const ButtonsScreen(),
  //   cards: (BuildContext context) => const CardsScreen(),
  //   home: (BuildContext context) => const HomeScreen()
  // };

  // static Map<String, Widget Function(BuildContext)> getAppRoutes() => appRoutes;

  // static Route<dynamic> onGenerateRoute(RouteSettings settings) {
  //   return CupertinoPageRoute(
  //       builder: (context) => appRoutes[settings.name]!(context));
  // }
}
