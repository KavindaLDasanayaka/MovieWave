import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviewave/src/movie/domain/entities/movie.dart';
import 'package:moviewave/src/movie/domain/usecases/get_upcoming_movies.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetUpcomingMovies _getUpcomingMovies;

  MovieBloc({required GetUpcomingMovies getUpcomingMovies})
    : _getUpcomingMovies = getUpcomingMovies,
      super(MovieInitial()) {
    on<GettingUpcomingMovies>(_onGettingUpcomingMovies);
  }

  Future<void> _onGettingUpcomingMovies(
    GettingUpcomingMovies event,
    Emitter<MovieState> emit,
  ) async {
    if (state is FetchedUpcomingMovies &&
        (state as FetchedUpcomingMovies).hasReachedMax) {
      return;
    }

    final currentState = state;

    final currentPage = (currentState is FetchedUpcomingMovies)
        ? currentState.currentPage
        : 0;

    final nextPage = currentPage + 1;

    if (event.page != nextPage) return;

    if (currentState is MovieInitial) {
      emit(MovieLoading());
    }

    final result = await _getUpcomingMovies(event.page);

    result.fold((failure) => emit(MovieError(failure.message)), (newMovies) {
      final movies = (currentState is FetchedUpcomingMovies)
          ? [...currentState.movies, ...newMovies]
          : newMovies;

      emit(
        FetchedUpcomingMovies(
          movies: movies,
          currentPage: nextPage,
          hasReachedMax: newMovies.isEmpty,
        ),
      );
    });
  }
}
