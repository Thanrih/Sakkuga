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
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        foregroundColor: Colors.transparent,
      ),
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
                return ListTile(
                  minVerticalPadding: 0,
                  horizontalTitleGap: 0,
                  title: Image.network(imageUrl),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
