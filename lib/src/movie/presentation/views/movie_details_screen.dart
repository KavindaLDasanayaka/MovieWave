import 'package:flutter/material.dart';
import 'package:moviewave/src/movie/domain/entities/movie.dart';
import 'package:moviewave/src/movie/presentation/widgets/movie_header_view.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key, required this.movie});

  final Movie movie;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  List<Movie> similarMovies = [];
  List<Movie> recommendedMovies = [];
  List<String> movieImages = [];
  bool isLoadingSimilar = false;
  bool isLoadingRecommended = false;
  bool isLoadingImages = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.movie.title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MovieHeaderView(movie: widget.movie),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Movie Images',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              _buildImageSection(),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Similar Movies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              _buildMovieSection(similarMovies, isLoadingSimilar),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Recommended Movies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              _buildMovieSection(recommendedMovies, isLoadingRecommended),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    if (isLoadingImages) {
      return const Center(child: CircularProgressIndicator());
    }
    if (movieImages.isEmpty) {
      return const Center(child: Text("No Images Found"));
    }
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movieImages.length,
        itemBuilder: (context, index) {
          String imageUrl = movieImages[index];
          return Container(
            width: 200,
            margin: const EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMovieSection(List<Movie> movies, bool isLoading) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (movies.isEmpty) {
      return const Center(child: Text("No Movies Found!"));
    }
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          Movie movie = movies[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(2),
              ),
              margin: const EdgeInsets.all(4.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (movie.posterPath != null)
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 100,
                      child: Text(
                        movie.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    Text(
                      'Average Vote: ${movie.voteAverage}',
                      style: TextStyle(fontSize: 7, color: Colors.red[600]),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
