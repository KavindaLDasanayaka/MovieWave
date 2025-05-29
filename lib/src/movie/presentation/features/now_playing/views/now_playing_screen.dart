import 'package:flutter/material.dart';
import 'package:moviewave/core/common/widgets/custom_appbar.dart';
import 'package:moviewave/src/movie/domain/entities/movie.dart';
import 'package:moviewave/src/movie/presentation/widgets/movie_card.dart';

class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({super.key});

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  List<Movie> movies = [];
  final ValueNotifier<int> currentPage = ValueNotifier<int>(1);
  int totalPages = 5;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  void _fetchMovies() {}

  void _nextPage() {
    if (currentPage.value < totalPages) {
      currentPage.value++;

      _fetchMovies();
    }
  }

  //method to prevous page
  void _previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
      _fetchMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Now Playing Movies"),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieCard(movie: movie);
              },
            ),
          ),
          _builPaginationControls(),
        ],
      ),
    );
  }

  _builPaginationControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: currentPage.value > 1 ? _previousPage : null,
            child: const Text("Previous"),
          ),

          ValueListenableBuilder(
            valueListenable: currentPage,
            builder: (context, value, child) =>
                Text('Page $value of $totalPages'),
          ),

          ElevatedButton(
            onPressed: currentPage.value < totalPages ? _nextPage : null,
            child: const Text("Next"),
          ),
        ],
      ),
    );
  }
}
