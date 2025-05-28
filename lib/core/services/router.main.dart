part of 'router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        return Routes.home;
      },
      builder: (_, __) {
        return const HomeScreen();
      },
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return NavigationScreen(state: state, child: child);
      },
      routes: [
        GoRoute(path: Routes.home, builder: (_, state) => const HomeScreen()),
        GoRoute(
          path: Routes.nowPlaying,
          builder: (_, state) => const NowPlayingScreen(),
        ),
        GoRoute(
          path: Routes.tvShow,
          builder: (_, state) => const TvShowScreen(),
        ),
        GoRoute(
          path: Routes.search,
          builder: (_, state) => const SearchScreen(),
        ),
      ],
    ),
    GoRoute(
      path: Routes.details,
      builder: (_, state) => MovieDetailsScreen(movie: state.extra as Movie),
    ),
  ],
);
