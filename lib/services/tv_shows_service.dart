import 'dart:convert';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moviewave/models/tv_show_model.dart';
import 'package:http/http.dart' as http;

class TvShowsService {
  //api key
  final String _apiKey = "";

  Future<List<TvShow>> fetchTvShows() async {
    try {
      final popularResponse = await http.get(
        Uri.parse(
          //popular tb shows
          "https://api.themoviedb.org/3/tv/popular?api_key=$_apiKey",
        ),
      );

      //airing today
      final airingTodayResponse = await http.get(
        Uri.parse(
          "https://api.themoviedb.org/3/tv/airing_today?api_key=$_apiKey",
        ),
      );

      //top rated
      final topratedResponse = await http.get(
        Uri.parse("https://api.themoviedb.org/3/tv/top_rated?api_key=$_apiKey"),
      );

      if (popularResponse.statusCode == 200 &&
          topratedResponse.statusCode == 200 &&
          airingTodayResponse.statusCode == 200) {
        final popularData = json.decode(popularResponse.body);
        final airingData = json.decode(airingTodayResponse.body);
        final topratedData = json.decode(topratedResponse.body);

        final List<dynamic> popularResult = popularData['results'];
        final List<dynamic> airingResult = airingData['results'];
        final List<dynamic> topratedResult = topratedData['results'];

        //uda thunema palaweni 10 gane aragena array ekak hadanawa.

        List<TvShow> tvShows = [];

        tvShows.addAll(
          popularResult.map((tvData) => TvShow.fromJson(tvData)).take(10),
        );
        tvShows.addAll(
          airingResult.map((tvData) => TvShow.fromJson(tvData)).take(10),
        );
        tvShows.addAll(
          topratedResult.map((tvData) => TvShow.fromJson(tvData)).take(10),
        );

        return tvShows;
      } else {
        throw Exception("Failed to load tv shows");
      }
    } catch (err) {
      print("Error : $err");
      return [];
    }
  }
}
