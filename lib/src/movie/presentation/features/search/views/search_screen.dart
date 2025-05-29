import 'package:flutter/material.dart';
import 'package:moviewave/core/common/widgets/custom_appbar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppbar(title: "Search Movies"));
  }
}
