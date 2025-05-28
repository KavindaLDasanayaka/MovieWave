import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviewave/core/common/entities/tv_show.dart';
import 'package:moviewave/csrc/tv_show/domain/usecases/get_popular.dart';
import 'package:moviewave/csrc/tv_show/domain/usecases/get_top_rated.dart';

part 'tv_show_event.dart';
part 'tv_show_state.dart';

class TvShowBloc extends Bloc<TvShowEvent, TvShowState> {
  final GetPopular _getPopular;
  final GetTopRated _getTopRated;
  TvShowBloc({required GetPopular getPopular, required GetTopRated getTopRated})
    : _getPopular = getPopular,
      _getTopRated = getTopRated,
      super(TvShowState()) {
    on<GetPopularTvShows>(_onGetPopularTvShows);
    on<GetTopRatedTvShows>(_onGetTopRatedTvShows);
  }

  Future<void> _onGetPopularTvShows(
    GetPopularTvShows event,
    Emitter<TvShowState> emit,
  ) async {
    emit(state.copyWith(isLoadingPopular: true));
    final result = await _getPopular();
    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingPopular: false, errorPopular: failure.message),
      ),
      (shows) => emit(
        state.copyWith(
          isLoadingPopular: false,
          popular: shows,
          errorPopular: null,
        ),
      ),
    );
  }

  Future<void> _onGetTopRatedTvShows(
    GetTopRatedTvShows event,
    Emitter<TvShowState> emit,
  ) async {
    emit(state.copyWith(isLoadingTopRated: true));
    final result = await _getTopRated();
    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoadingTopRated: false,
          errorTopRated: failure.message,
        ),
      ),
      (shows) => emit(
        state.copyWith(
          isLoadingTopRated: false,
          topRated: shows,
          errorTopRated: null,
        ),
      ),
    );
  }
}
