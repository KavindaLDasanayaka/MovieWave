part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _movieInit();
  await _tvShowInit();
}

Future<void> _movieInit() async {
  sl
    ..registerLazySingleton(http.Client.new)
    ..registerLazySingleton<MovieRemoteDataSrc>(
      () => MovieRemoteDataSrcImpl(sl()),
    )
    ..registerLazySingleton<MovieRepo>(() => MovieRepoImpl(sl()))
    ..registerLazySingleton(() => GetUpcomingMovies(sl()))
    ..registerLazySingleton(() => MovieBloc(getUpcomingMovies: sl()));
}

Future<void> _tvShowInit() async {
  sl
    ..registerLazySingleton<TvShowRemoteDataSrc>(
      () => TvShowRemoteDataSrcImpl(sl()),
    )
    ..registerLazySingleton<TvShowRepo>(() => TvShowRepoImpl(sl()))
    ..registerLazySingleton(() => GetPopular(sl()))
    ..registerLazySingleton(() => GetTopRated(sl()))
    ..registerLazySingleton(
      () => TvShowBloc(getPopular: sl(), getTopRated: sl()),
    );
}
