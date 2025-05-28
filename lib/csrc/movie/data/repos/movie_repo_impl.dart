import 'package:dartz/dartz.dart';
import 'package:moviewave/core/common/entities/movie.dart';
import 'package:moviewave/core/errors/exceptions.dart';
import 'package:moviewave/core/errors/failures.dart';
import 'package:moviewave/core/utils/typedefs.dart';
import 'package:moviewave/csrc/movie/data/datasources/movie_remote_data_src.dart';
import 'package:moviewave/csrc/movie/domain/repos/movie_repo.dart';

class MovieRepoImpl implements MovieRepo {
  const MovieRepoImpl(this._remoteDataSource);

  final MovieRemoteDataSrc _remoteDataSource;

  @override
  ResultFuture<List<Movie>> getUpcomingMovies({required int page}) async {
    try {
      final result = await _remoteDataSource.getUpcomingMovies(page: page);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
