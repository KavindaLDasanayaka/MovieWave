import 'package:moviewave/src/tv_show/data/models/tv_show_model.dart';

abstract class TvShowRemoteDataSrc {
  const TvShowRemoteDataSrc();

  Future<List<TvShowModel>> getPopular();
  Future<List<TvShowModel>> getTopRated();
}
