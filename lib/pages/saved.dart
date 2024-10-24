import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sakugaacaptors/assets/card.dart';
import 'package:sakugaacaptors/pages/homepage.dart';
import '../providers/provider_favorites.dart';
import 'package:flutter/cupertino.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  Future<List<Map<String, dynamic>>> data() async {
    final response = await supabase.from('Obras').select('*');
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const CupertinoSearchTextField(),
            const SizedBox(height: 20),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: data(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No images found',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  final dataList = snapshot.data!.sublist(0, 5); // Limite para 5 itens
                  final screenWidth = MediaQuery.of(context).size.width;
                  final spacing = screenWidth * 0.018; // 2% da largura da tela

                  return SingleChildScrollView(
                    child: Container(
                      alignment: Alignment.topLeft, // Alinha os itens ao início
                      child: Wrap(
                        spacing: spacing, // Espaçamento horizontal entre os itens
                        runSpacing: 8.0, // Espaçamento vertical entre as linhas
                        children: dataList.map((data) {
                          return SizedBox(
                            width: 150, // Largura fixa para os cards
                            height: 250, // Altura fixa para os cards
                            child: MangaCard(
                              imageUrl: data['ImageUrl'],
                              title: data['Name'],
                              textSize: 16,
                              textPadding: 0,
                              desc: '',
                              id: data['id'],
                              obraGenres: data['genres'],
                              views: data['views'],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}