import 'package:flutter/material.dart';
import 'package:moviewave/pages/home_page.dart';
import 'package:moviewave/pages/now_playing_page.dart';
import 'package:moviewave/pages/search_page.dart';
import 'package:moviewave/pages/tvshow_page.dart';
import 'package:moviewave/utils/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    NowPlayingPage(),
    TvShowsPage(),
    SearchPage(),
  ];

  void _onTap(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) => _onTap(value),
        unselectedItemColor: Colors.grey,
        selectedItemColor: AppColors.mainColor,

        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(
            label: "Now Playing",
            icon: Icon(Icons.play_circle_fill),
          ),
          BottomNavigationBarItem(
            label: "Tv Shows",
            icon: Icon(Icons.movie_creation_outlined),
          ),
          BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search)),
        ],
      ),

      body: _pages[_currentIndex],
    );
  }
}
