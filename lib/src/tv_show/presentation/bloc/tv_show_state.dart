part of 'tv_show_bloc.dart';

final class TvShowState extends Equatable {
  const TvShowState({
    this.popular = const [],
    this.topRated = const [],
    this.isLoadingPopular = false,
    this.isLoadingTopRated = false,
    this.errorPopular,
    this.errorTopRated,
  });

  final List<TvShow> popular;
  final List<TvShow> topRated;

  final bool isLoadingPopular;
  final bool isLoadingTopRated;

  final String? errorPopular;
  final String? errorTopRated;

  TvShowState copyWith({
    List<TvShow>? popular,
    List<TvShow>? topRated,
    bool? isLoadingPopular,
    bool? isLoadingTopRated,
    String? errorPopular,
    String? errorTopRated,
  }) {
    return TvShowState(
      popular: popular ?? this.popular,
      topRated: topRated ?? this.topRated,
      isLoadingPopular: isLoadingPopular ?? this.isLoadingPopular,
      isLoadingTopRated: isLoadingTopRated ?? this.isLoadingTopRated,
      errorPopular: errorPopular,
      errorTopRated: errorTopRated,
    );
  }

  @override
  List<Object?> get props => [
    popular,
    topRated,
    isLoadingPopular,
    isLoadingTopRated,
    errorPopular,
    errorTopRated,
  ];
}
