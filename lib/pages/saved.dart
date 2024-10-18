import 'package:flutter/cupertino.dart';
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
      body: const Padding(
    padding: EdgeInsets.all(8.0),
    child: CupertinoSearchTextField(
    ),
      ),
    );
  }
}
