import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/provider_favorites.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        foregroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final obraId = favorites[index];
          return ListTile(
            title: Text('Obra $obraId'), // Here you can fetch and display more details of the favorite obra
          );
        },
      ),
    );
  }
}
