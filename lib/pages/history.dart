import 'package:flutter/material.dart';
import 'package:sakugaacaptors/assets/card.dart';
import 'package:sakugaacaptors/pages/homepage.dart';
import 'package:flutter/cupertino.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String searchQuery = '';

  Future<List<Map<String, dynamic>>> _data() async {
    final userId = supabase.auth.currentUser?.id;
    print(userId);
    if (userId == null) {
      print('Usuário não autenticado.');
      return [];
    }

    try {
      // Realiza a consulta em "Histórico" para obter os IDs das obras do usuário.
      final historyResponse = await supabase
          .from('Histórico')
          .select('id_history')
          .eq('userId', userId);

      print(historyResponse);

      // Extrai os IDs das obras do histórico.
      final obraIds = historyResponse.map((history) => history['id_history'] as int).toList();
      if (obraIds.isEmpty) {
        print('Nenhuma obra encontrada no histórico.');
        return [];
      }
      print(obraIds.length);

      // Formata os IDs em formato SQL.
      final obraIdsFormatted = '(${obraIds.join(",")})';
      final response = await supabase
          .from('Obras')
          .select('*')
          .filter('id', 'in', obraIdsFormatted);

      // Converte o resultado em uma lista de mapas para facilitar o uso.
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Erro ao buscar dados: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;

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
                  searchQuery = value.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _data(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return _buildErrorWidget(snapshot.error.toString());
                  } else if (user == null) {
                    return _buildNotLoggedInWidget();
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return _buildNoHistoryFoundWidget();
                  } else {
                    return _buildHistoryList(snapshot.data!);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 50),
          const SizedBox(height: 10),
          Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
          ElevatedButton(
            onPressed: () => setState(() {}),
            child: const Text('Tentar Novamente'),
          ),
        ],
      ),
    );
  }

  Widget _buildNotLoggedInWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Você não está logado',
          style: TextStyle(color: Colors.white),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, 'pages/login');
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(200, 40),
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Text(
            'Login',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoHistoryFoundWidget() {
    return const Center(
      child: Text(
        'Nenhum histórico encontrado',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildHistoryList(List<Map<String, dynamic>> dataList) {
    final filteredData = dataList.where((data) {
      return data['Name'].toLowerCase().contains(searchQuery);
    }).toList();

    if (filteredData.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum resultado encontrado para sua pesquisa.',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = screenWidth * 0.02;

    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: spacing,
          runSpacing: 8.0,
          children: filteredData.map((data) {
            return SizedBox(
              width: 119,
              height: 200,
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
}
