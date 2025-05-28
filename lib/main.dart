import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:moviewave/core/common/widgets/loader.dart';
import 'package:moviewave/core/services/injection_container.dart';
import 'package:moviewave/core/services/router.dart';
import 'package:moviewave/core/utils/core_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviewave/csrc/movie/presentation/bloc/movie_bloc.dart';
import 'package:moviewave/csrc/tv_show/presentation/bloc/tv_show_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<MovieBloc>()),
        BlocProvider(create: (_) => sl<TvShowBloc>()),
      ],
      child: const MovieWaveApp(),
    ),
  );
}

class MovieWaveApp extends StatelessWidget {
  const MovieWaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayWidgetBuilder: (_) {
        return Loader.indicator();
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "Movie Wave",
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
          brightness: Brightness.dark,
        ),
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        routerConfig: router,
      ),
    );
  }
}
