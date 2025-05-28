part of 'movie_bloc.dart';

sealed class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

final class MovieInitial extends MovieState {}

final class MovieLoading extends MovieState {}

final class MovieError extends MovieState {
  const MovieError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

final class FetchedUpcomingMovies extends MovieState {
  const FetchedUpcomingMovies({
    required this.movies,
    required this.currentPage,
    required this.hasReachedMax,
  });

  final List<Movie> movies;
  final int currentPage;
  final bool hasReachedMax;

  @override
  List<Object> get props => [movies, currentPage, hasReachedMax];
}
