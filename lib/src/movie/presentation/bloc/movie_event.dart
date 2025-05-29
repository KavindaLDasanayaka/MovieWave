part of 'movie_bloc.dart';

sealed class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

final class GettingUpcomingMovies extends MovieEvent {
  const GettingUpcomingMovies({required this.page});

  final int page;

  @override
  List<Object> get props => [page];
}
