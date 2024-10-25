import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sakugaacaptors/assets/card.dart';
import 'package:sakugaacaptors/pages/homepage.dart';
import '../providers/provider_favorites.dart';
import 'package:flutter/cupertino.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String searchQuery = '';

  Future<List<Map<String, dynamic>>> fetchHistoryData() async {
    final response = await supabase.from('Histórico').select('id_history');
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CupertinoSearchTextField(
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase(); // Atualiza a consulta de pesquisa
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchHistoryData(),
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
                        'No history found',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    // Filtra os dados com base na consulta de pesquisa
                    final dataList = snapshot.data!;
                    final filteredData = dataList.where((data) {
                      return data['Name'].toLowerCase().contains(searchQuery);
                    }).toList();

                    final screenWidth = MediaQuery.of(context).size.width;
                    final spacing = screenWidth * 0.02; // 2% da largura da tela

                    return SingleChildScrollView(
                      child: Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: spacing, // Espaçamento horizontal entre os itens
                          runSpacing: 8.0, // Espaçamento vertical entre as linhas
                          children: filteredData.map((data) {
                            return SizedBox(
                              width: 119, // Largura fixa para os cards
                              height: 200, // Altura fixa para os cards
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
            ),
          ],
        ),
      ),
    );
  }
}