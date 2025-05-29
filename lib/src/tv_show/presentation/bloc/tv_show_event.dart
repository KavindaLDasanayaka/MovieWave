part of 'tv_show_bloc.dart';

sealed class TvShowEvent extends Equatable {
  const TvShowEvent();

  @override
  List<Object> get props => [];
}

final class GetPopularTvShows extends TvShowEvent {
  const GetPopularTvShows();
}

final class GetTopRatedTvShows extends TvShowEvent {
  const GetTopRatedTvShows();
}
