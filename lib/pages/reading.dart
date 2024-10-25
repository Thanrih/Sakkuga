import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReadingPage extends StatefulWidget {
  const ReadingPage({super.key});

  @override
  State<ReadingPage> createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  late Future<List<String>> _futureImages;
  late String id;
  late String cap;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    id = args['id'];
    cap = args['cap'].toString();
    _futureImages = fetchImages(id, cap);
  }

  Future<List<String>> fetchImages(String id, String cap) async {
    final response = await Supabase.instance.client
        .from('Pages')
        .select('page')
        .eq('id', id)
        .eq('cap', cap)
        .single();

    final List<dynamic> pageUrls = response['page'];
    return pageUrls.cast<String>();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Deixa a cor de fundo transparente
        elevation: 0, // Remove a sombra da AppBar
        iconTheme: const IconThemeData(color: Colors.white), // Define a cor dos ícones
        toolbarOpacity: 1, // Define a opacidade da AppBar
      ),
      extendBodyBehindAppBar: true, // Permite que o corpo da página se estenda

      body: FutureBuilder<List<String>>(
        future: _futureImages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No images found'));
          }

          final imageUrls = snapshot.data!;
          return Scrollbar(
            child: ListView.builder(
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                final imageUrl = imageUrls[index];
                return SizedBox(
                  width: double.infinity, // Largura total da tela
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover, // Faz a imagem cobrir toda a largura
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
