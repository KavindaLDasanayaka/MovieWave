import 'package:dartz/dartz.dart';
import 'package:moviewave/core/common/entities/tv_show.dart';
import 'package:moviewave/core/errors/exceptions.dart';
import 'package:moviewave/core/errors/failures.dart';
import 'package:moviewave/core/utils/typedefs.dart';
import 'package:moviewave/csrc/tv_show/data/datasources/tv_show_remote_data_src.dart';
import 'package:moviewave/csrc/tv_show/domain/repos/tv_show_repo.dart';

class TvShowRepoImpl implements TvShowRepo {
  const TvShowRepoImpl(this._remoteDataSource);

  final TvShowRemoteDataSrc _remoteDataSource;

  @override
  ResultFuture<List<TvShow>> getPopular() async {
    try {
      final result = await _remoteDataSource.getPopular();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<TvShow>> getTopRated() async {
    try {
      final result = await _remoteDataSource.getTopRated();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
