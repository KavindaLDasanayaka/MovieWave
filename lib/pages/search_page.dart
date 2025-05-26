import 'package:flutter/material.dart';
import 'package:moviewave/models/movie_model.dart';
import 'package:moviewave/services/movie_service.dart';
import 'package:moviewave/utils/colors.dart';
import 'package:moviewave/widgets/search_detail.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Movie> _movies = [];
  bool _isLoading = false;
  String _error = "";

  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  //search movie
  Future<void> _searchMovie() async {
    if (_isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
      _error = "";
    });

    try {
      final movies = await MovieService().searchMovie(
        _controller.text.toLowerCase(),
      );

      setState(() {
        _movies = movies;
      });
    } catch (err) {
      print("Error searching:$err");
      _error = "Failed to search that movie $err";
    } finally {
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Page",
          style: TextStyle(color: AppColors.titleColor),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Search for a movie",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onSubmitted: (_) => _searchMovie(),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.redAccent,
                      ),

                      child: IconButton(
                        onPressed: () {
                          _searchMovie();
                        },
                        icon: Icon(Icons.search, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else if (_error.isNotEmpty)
                Padding(
                  padding: EdgeInsetsGeometry.all(8),
                  child: Text(
                    _error,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              else if (_movies.isEmpty)
                const Center(child: Text("No movies found! Please search"))
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: _movies.length,
                    itemBuilder: (context, index) {
                      Movie movie = _movies[index];
                      return Column(
                        children: [SearchDetailWidget(movie: movie)],
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
