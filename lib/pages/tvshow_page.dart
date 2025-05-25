import 'package:flutter/material.dart';
import 'package:moviewave/utils/colors.dart';

class TvShowsPage extends StatefulWidget {
  const TvShowsPage({super.key});

  @override
  State<TvShowsPage> createState() => _TvShowsPageState();
}

class _TvShowsPageState extends State<TvShowsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TV Shows Page",
          style: TextStyle(color: AppColors.titleColor),
        ),
      ),
    );
  }
}
