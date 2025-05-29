import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviewave/core/common/widgets/custom_appbar.dart';
import 'package:moviewave/core/common/widgets/loader.dart';
import 'package:moviewave/src/movie/presentation/bloc/movie_bloc.dart';
import 'package:moviewave/src/movie/presentation/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(const GettingUpcomingMovies(page: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Movie Wave"),
      body: SafeArea(
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieLoading) {
              return Loader.indicator();
            } else if (state is FetchedUpcomingMovies) {
              final movies = state.movies;
              return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  if (notification.metrics.pixels ==
                          notification.metrics.maxScrollExtent &&
                      !state.hasReachedMax) {
                    context.read<MovieBloc>().add(
                      GettingUpcomingMovies(page: state.currentPage + 1),
                    );
                  }
                  return true;
                },
                child: ListView.builder(
                  itemCount: movies.length + (state.hasReachedMax ? 0 : 1),
                  itemBuilder: (context, index) {
                    if (index == movies.length) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Loader.indicator(),
                      );
                    }
                    return MovieCard(movie: movies[index]);
                  },
                ),
              );
            } else if (state is MovieError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
