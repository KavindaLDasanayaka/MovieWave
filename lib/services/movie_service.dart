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
      throw Exception("Failed to fetch movies:$err");
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
      throw Exception("Failed to fetch now playing movies:$err");
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
      throw Exception("Failed to search movies:$error");
    }
  }

  //similar movies
  Future<List<Movie>> fetchSimilarMovies(int movieId) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieId/similar?api_key=$_apiKey",
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final List<dynamic> results = data['results'];

        final List<Movie> similarMovies = results
            .map((movieData) => Movie.fromJson(movieData))
            .toList();

        return similarMovies;
      } else {
        throw Exception("Failed to fetch similar movies");
      }
    } catch (err) {
      print("Failed to fetch similar movies: $err");
      return [];
    }
  }

  //recommonded movies
  Future<List<Movie>> fetchRecomondedMovies(int movieId) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieId/recommendations?api_key=$_apiKey",
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final List<dynamic> results = data['results'];

        final List<Movie> recomondedMovies = results
            .map((movieData) => Movie.fromJson(movieData))
            .toList();

        return recomondedMovies;
      } else {
        throw Exception("Failed to fetch recommended movies");
      }
    } catch (err) {
      print("Failed to fetch recommended movies: $err");
      return [];
    }
  }

  //fetch images using movie if
  Future<List<String>> fetchImagesFromMovieId(int movieId) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieId/images?api_key=$_apiKey",
        ),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> backdrops = data['backdrops'];

        //extract file paths and return the first 10 images
        return backdrops
            .take(10)
            .map(
              (imageData) =>
                  "https://image.tmdb.org/t/p/w500${imageData['file_path']}",
            )
            .toList();
      } else {
        throw Exception("Error fecthing images");
      }
    } catch (err) {
      print("Error fetching images :$err");
      return [];
    }
  }
}
