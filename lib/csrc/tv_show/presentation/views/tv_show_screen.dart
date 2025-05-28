import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviewave/core/common/widgets/loader.dart';
import 'package:moviewave/csrc/tv_show/presentation/bloc/tv_show_bloc.dart';
import 'package:moviewave/csrc/tv_show/presentation/widgets/tv_show_card.dart';

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
      appBar: AppBar(
        title: Text(
          "TV Shows",
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            fontSize: 29,
          ),
        ),
      ),
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
