import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<int> _favorites = [];

  List<int> get favorites => _favorites;

  void toggleFavorite(int obraId) {
    if (_favorites.contains(obraId)) {
      _favorites.remove(obraId);
    } else {
      _favorites.add(obraId);
    }
    notifyListeners();
  }

  bool isFavorite(int obraId) {
    return _favorites.contains(obraId);
  }
}
