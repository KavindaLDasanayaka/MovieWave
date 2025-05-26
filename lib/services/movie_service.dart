import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moviewave/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieService {
  //api key
  final String _apiKey = dotenv.env['TMDB_DATABASE_KEY'] ?? "";

  final String _baseUrl = "https://api.themoviedb.org/3/movie/upcoming";

  //method to fetch upcoming movies
  Future<List<Movie>> fetchUpcomingMovies({int page = 1}) async {
    final String url = "$_baseUrl?api_key=$_apiKey&page=$page";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final List<dynamic> results = data["results"];

        final List<Movie> movieList = results
            .map((movieData) => Movie.fromJson(movieData))
            .toList();

        return movieList;
      } else {
        throw Exception("Failed to fetch movies");
      }
    } catch (err) {
      print("Error fetching movies: $err");
      return [];
    }
  }

  //fetch all now playng movies
  Future<List<Movie>> fetchNowPLayingMovies({int page = 1}) async {
    final String url =
        "https://api.themoviedb.org/3/movie/now_playing?api_key=$_apiKey&page=$page";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final List<dynamic> results = data['results'];

        final List<Movie> nowPlayingMovies = results
            .map((movieData) => Movie.fromJson(movieData))
            .toList();

        return nowPlayingMovies;
      } else {
        throw Exception("Failed to fetch now playing movies");
      }
    } catch (err) {
      print("Error now playing: $err");
      return [];
    }
  }

  //search movies by query
  Future<List<Movie>> searchMovie(String query) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.themoviedb.org/3/search/movie?query=$query&api_key=$_apiKey',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((movieData) => Movie.fromJson(movieData)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (error) {
      print('Error fetching movies service: $error');
      return [];
    }
  }
}
