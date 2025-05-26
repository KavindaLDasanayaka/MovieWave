import 'package:flutter/material.dart';
import 'package:moviewave/models/tv_show_model.dart';
import 'package:moviewave/services/tv_shows_service.dart';
import 'package:moviewave/utils/colors.dart';
import 'package:moviewave/widgets/tv_show_widget.dart';

class TvShowsPage extends StatefulWidget {
  const TvShowsPage({super.key});

  @override
  State<TvShowsPage> createState() => _TvShowsPageState();
}

class _TvShowsPageState extends State<TvShowsPage> {
  List<TvShow> _tvshows = [];
  bool _isLoading = true;
  String _error = "";

  //method to fetch tv shows
  Future<void> _fetchTvShows() async {
    try {
      List<TvShow> tvShows = await TvShowsService().fetchTvShows();

      setState(() {
        _tvshows = tvShows;
        _isLoading = false;
      });
    } catch (err) {
      print("Error tv shows page: $err");
      setState(() {
        _isLoading = false;
        _error = "Failed to load tv shows";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchTvShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TV Shows Page",
          style: TextStyle(color: AppColors.titleColor),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
          ? Center(child: Text(_error))
          : ListView.builder(
              itemCount: _tvshows.length,
              itemBuilder: (context, index) {
                TvShow tvShow = _tvshows[index];
                return TvShowWidget(tvShow: tvShow);
              },
            ),
    );
  }
}
