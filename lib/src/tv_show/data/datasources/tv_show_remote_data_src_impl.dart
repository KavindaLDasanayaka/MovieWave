import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:moviewave/core/common/singletons/cache.dart';
import 'package:moviewave/core/errors/exceptions.dart';
import 'package:moviewave/core/extensions/json_extension.dart';
import 'package:moviewave/core/utils/constants/network_constant.dart';
import 'package:moviewave/core/utils/typedefs.dart';
import 'package:moviewave/src/tv_show/data/datasources/tv_show_remote_data_src.dart';
import 'package:moviewave/src/tv_show/data/models/tv_show_model.dart';

class TvShowRemoteDataSrcImpl implements TvShowRemoteDataSrc {
  const TvShowRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<List<TvShowModel>> getPopular() async {
    try {
      final queryParameters = {"api_key": Cache.instance.apiKey};

      final url = Uri.https(
        BASE_URL,
        "$VERSION$TV_DOMAIN$POPULAR",
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
      final tvShows = (payload['results'] as List<dynamic>)
          .map((e) => TvShowModel.fromMap(e as DataMap))
          .toList();
      return tvShows.take(10).toList();
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

  @override
  Future<List<TvShowModel>> getTopRated() async {
    try {
      final queryParameters = {"api_key": Cache.instance.apiKey};

      final url = Uri.https(
        BASE_URL,
        "$VERSION$TV_DOMAIN$TOP_RATED",
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
      final tvShows = (payload['results'] as List<dynamic>)
          .map((e) => TvShowModel.fromMap(e as DataMap))
          .toList();
      return tvShows.take(10).toList();
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
