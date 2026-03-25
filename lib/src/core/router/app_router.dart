import 'package:go_router/go_router.dart';
import 'package:pbl5_mobile/src/module/shell/shell.dart';
import 'package:pbl5_mobile/src/module/tracker/presentation/tracker_page.dart';
import 'package:pbl5_mobile/src/module/vision_feed/presentation/vision_feed_page.dart';

import 'route_names.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteNames.home,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return DashboardShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [GoRoute(path: '/', builder: (_, _) => const VisionFeedPage())],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/tracker',
                builder: (_, _) => const TrackerPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
