import 'package:flutter/material.dart';
import 'package:moviewave/models/movie_model.dart';
import 'package:moviewave/services/movie_service.dart';
import 'package:moviewave/widgets/search_detail.dart';

class SingleMoviePage extends StatefulWidget {
  final Movie movie;
  const SingleMoviePage({super.key, required this.movie});

  @override
  State<SingleMoviePage> createState() => _SingleMoviePageState();
}

class _SingleMoviePageState extends State<SingleMoviePage> {
  List<Movie> _similarMovies = [];
  List<Movie> _recommendedMovies = [];
  List<String> _movieImages = [];
  bool _isLoadingSimilar = true;
  bool _isLoadingRecommended = true;
  bool _isLoadingImages = true;

  //fetch similar movies
  Future<void> _fetchSimilarMovies() async {
    try {
      List<Movie> fetchedMovies = await MovieService().fetchSimilarMovies(
        widget.movie.id,
      );
      setState(() {
        _similarMovies = fetchedMovies;
        _isLoadingSimilar = false;
      });
    } catch (err) {
      print("Error from similar: $err");
      setState(() {
        _isLoadingSimilar = false;
      });
    } finally {
      _isLoadingSimilar = false;
    }
  }

  //fetch recommended movies
  Future<void> _fetchRecommendedMovies() async {
    try {
      List<Movie> fetchedMovies = await MovieService().fetchRecomondedMovies(
        widget.movie.id,
      );
      setState(() {
        _recommendedMovies = fetchedMovies;
        _isLoadingRecommended = false;
      });
    } catch (err) {
      print("Error from recommended: $err");
      setState(() {
        _isLoadingRecommended = false;
      });
    } finally {
      _isLoadingRecommended = false;
    }
  }

  //fetch images movies
  Future<void> _fetchImages() async {
    try {
      List<String> fetchImages = await MovieService().fetchImagesFromMovieId(
        widget.movie.id,
      );
      setState(() {
        _movieImages = fetchImages;
        _isLoadingImages = false;
      });
    } catch (err) {
      print("Error from loading images: $err");
      setState(() {
        _isLoadingImages = false;
      });
    } finally {
      _isLoadingImages = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSimilarMovies();
    _fetchRecommendedMovies();
    _fetchImages();
  }

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
              SearchDetailWidget(movie: widget.movie),
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
              _buildMovieSection(_similarMovies, _isLoadingSimilar),
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
              _buildMovieSection(_recommendedMovies, _isLoadingRecommended),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    if (_isLoadingImages) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_movieImages.isEmpty) {
      return const Center(child: Text("No Images Found"));
    }
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _movieImages.length,
        itemBuilder: (context, index) {
          String imageUrl = _movieImages[index];
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
            //mekedi wenne aye movie ekak hadagnnawa
            onTap: () {
              setState(() {
                // widget.movie = movie;
                _fetchSimilarMovies();
                _fetchImages();
                _fetchRecommendedMovies();
              });
            },
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
