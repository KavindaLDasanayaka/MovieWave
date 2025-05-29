import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:moviewave/core/common/singletons/cache.dart';
import 'package:moviewave/core/errors/exceptions.dart';
import 'package:moviewave/core/extensions/json_extension.dart';
import 'package:moviewave/core/utils/constants/network_constant.dart';
import 'package:moviewave/core/utils/typedefs.dart';
import 'package:moviewave/src/movie/data/datasources/movie_remote_data_src.dart';
import 'package:moviewave/src/movie/data/models/movie_model.dart';

class MovieRemoteDataSrcImpl implements MovieRemoteDataSrc {
  const MovieRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<List<MovieModel>> getUpcomingMovies({required int page}) async {
    try {
      final queryParameters = {
        "api_key": Cache.instance.apiKey,
        "page": "$page",
      };

      final url = Uri.https(
        BASE_URL,
        "$VERSION$MOVIE_DOMAIN$UPCOMING",
        queryParameters,
      );

      final response = await _client.get(url, headers: HEADERS);

      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      final payload = response.body.toJson;
      final movies = (payload['results'] as List<dynamic>)
          .map((e) => MovieModel.fromMap(e as DataMap))
          .toList();
      return movies;
    } on SocketException {
      throw const ServerException(
        message: 'No internet connection',
        statusCode: 0,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: 500);
    }
  }
}
