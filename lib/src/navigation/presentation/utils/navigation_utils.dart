import 'package:go_router/go_router.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:moviewave/core/services/routes.dart';

abstract class NavigationUtils {
  static final icons = [
    (MingCuteIcons.mgc_home_3_line, MingCuteIcons.mgc_home_3_fill, "Home"),
    (
      MingCuteIcons.mgc_play_circle_line,
      MingCuteIcons.mgc_play_circle_fill,
      "Now Playing",
    ),
    (MingCuteIcons.mgc_movie_line, MingCuteIcons.mgc_movie_fill, "Tv Shows"),
    (
      MingCuteIcons.mgc_search_2_line,
      MingCuteIcons.mgc_search_2_fill,
      "Search",
    ),
  ];

  static int activeIndex(GoRouterState state) {
    return switch (state.fullPath) {
      Routes.home => 0,
      Routes.nowPlaying => 1,
      Routes.tvShow => 2,
      Routes.search => 3,
      _ => 0,
    };
  }
}
