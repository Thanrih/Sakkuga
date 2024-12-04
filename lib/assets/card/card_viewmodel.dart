import 'package:flutter/material.dart';

class MangaViewModel {
  final int id;
  final String imageUrl;
  final String title;
  final String badge;
  final String desc;
  final double textPadding;
  final double textSize;
  final int views;
  final List<dynamic> obraGenres;

  MangaViewModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    this.badge = '',
    this.desc = '',
    this.textPadding = 0,
    this.textSize = 0,
    required this.obraGenres,
    required this.views,
  });

  // You can add methods here if needed, for example:
  String get firstGenre => obraGenres.isNotEmpty ? obraGenres[0] : '';
}