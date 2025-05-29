import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviewave/core/common/widgets/custom_appbar.dart';
import 'package:moviewave/core/common/widgets/loader.dart';
import 'package:moviewave/src/tv_show/presentation/bloc/tv_show_bloc.dart';
import 'package:moviewave/src/tv_show/presentation/widgets/tv_show_card.dart';

class TvShowScreen extends StatefulWidget {
  const TvShowScreen({super.key});

  @override
  State<TvShowScreen> createState() => _TvShowScreenState();
}

class _TvShowScreenState extends State<TvShowScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TvShowBloc>().add(const GetPopularTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "TV Shows"),
      body: SafeArea(
        child: BlocBuilder<TvShowBloc, TvShowState>(
          builder: (context, state) {
            if (state.isLoadingPopular) {
              return Loader.indicator();
            } else if (state.popular.isNotEmpty) {
              return ListView.builder(
                itemCount: state.popular.length,
                itemBuilder: (context, index) {
                  final tvShow = state.popular[index];
                  return TvShowCard(tvShow: tvShow);
                },
              );
            } else if (state.errorPopular != null) {
              return Center(child: Text(state.errorPopular!));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
