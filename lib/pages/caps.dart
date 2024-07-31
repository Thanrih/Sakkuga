import 'package:flutter/material.dart';
import 'package:sakugaacaptors/pages/reading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Caps extends StatefulWidget {
  const Caps({Key? key}) : super(key: key);

  @override
  State<Caps> createState() => _CapsState();
}

class _CapsState extends State<Caps> {
  late Future<List<int>> _futureChapters;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = ModalRoute.of(context)!.settings.arguments as String;
    _futureChapters = fetchChapters(id);
  }

  Future<List<int>> fetchChapters(String id) async {
    final response = await Supabase.instance.client
        .from('Pages')
        .select('cap')
        .eq('id', id)
    ;

    if (response == null) {
      throw response;
    }

    final List<dynamic> data = response as List<dynamic>;
    final List<int> chapters = data.map<int>((item) => item['cap'] as int).toList();
    return chapters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        foregroundColor: Colors.transparent,
      ),
      body: FutureBuilder<List<int>>(
        future: _futureChapters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao buscar capítulos: ${snapshot.error}'),
            );
          }
          final chapters = snapshot.data ?? [];
          return ListView.builder(
            itemCount: chapters.length,
            itemBuilder: (context, index) {
              final chapter = chapters[index];
              return ListTile(
                title: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                    onTap: () {
                      final id = ModalRoute.of(context)!.settings.arguments as String;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReadingPage(),
                          settings: RouteSettings(
                            arguments: {
                              'id': id,
                              'cap': chapter,
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5.0), // Espaçamento ao redor do texto
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0), // Borda arredondada
                        color: Colors.transparent, // Cor de fundo transparente
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Capítulo $chapter',
                                style: const TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ],
                          ),
                      Divider(
                            thickness: 0.1,
                            color: Colors.grey[400],
                          )
                        ],

                      ),

                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
