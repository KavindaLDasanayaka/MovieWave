import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:moviewave/csrc/movie/data/datasources/movie_remote_data_src.dart';
import 'package:moviewave/csrc/movie/data/datasources/movie_remote_data_src_impl.dart';
import 'package:moviewave/csrc/movie/data/repos/movie_repo_impl.dart';
import 'package:moviewave/csrc/movie/domain/repos/movie_repo.dart';
import 'package:moviewave/csrc/movie/domain/usecases/get_upcoming_movies.dart';
import 'package:moviewave/csrc/movie/presentation/bloc/movie_bloc.dart';
import 'package:moviewave/csrc/tv_show/data/datasources/tv_show_remote_data_src.dart';
import 'package:moviewave/csrc/tv_show/data/datasources/tv_show_remote_data_src_impl.dart';
import 'package:moviewave/csrc/tv_show/data/repos/tv_show__repo_impl.dart';
import 'package:moviewave/csrc/tv_show/domain/repos/tv_show_repo.dart';
import 'package:moviewave/csrc/tv_show/domain/usecases/get_popular.dart';
import 'package:moviewave/csrc/tv_show/domain/usecases/get_top_rated.dart';
import 'package:moviewave/csrc/tv_show/presentation/bloc/tv_show_bloc.dart';

part 'injection_container.main.dart';
