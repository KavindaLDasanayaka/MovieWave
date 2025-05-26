import 'package:flutter/material.dart';
import 'package:moviewave/models/movie_model.dart';
import 'package:moviewave/services/movie_service.dart';
import 'package:moviewave/widgets/movie_detail_widget.dart';

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({super.key});

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  List<Movie> _movies = [];
  int _currentPage = 1;
  int _totalPages = 1;
  bool _isLoading = false;

  //

  Future<void> _fetchMovies() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final newMovies = await MovieService().fetchNowPLayingMovies(
        page: _currentPage + 1,
      );
      setState(() {
        _movies = newMovies;
        _totalPages = 100;
      });
    } catch (err) {
      print("Error now playing: $err");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  //method to next page
  void _nextPage() {
    if (_currentPage < _totalPages) {
      setState(() {
        _currentPage++;
      });

      _fetchMovies();
    }
  }

  //method to prevous page
  void _previousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
      });
      _fetchMovies();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Now Playing Movies")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _movies.length + 1,
                    itemBuilder: (context, index) {
                      if (index > _movies.length - 1) {
                        return _builPaginationControls();
                      } else {
                        Movie movie = _movies[index];
                        return MovieDetailWidget(movie: movie);
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _builPaginationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _currentPage > 1 ? _previousPage : null,
          child: const Text("Previous"),
        ),

        const SizedBox(width: 8),
        Text('Page $_currentPage of $_totalPages'),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: _currentPage < _totalPages ? _nextPage : null,
          child: const Text("Next"),
        ),
      ],
    );
  }
}
