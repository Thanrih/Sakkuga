import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakugaacaptors/assets/my_button.dart';
import 'package:sakugaacaptors/pages/history.dart';
import 'package:sakugaacaptors/pages/homepage.dart';
import 'package:sakugaacaptors/pages/saved.dart';
import 'package:sakugaacaptors/pages/settings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class ObraDescPage extends StatefulWidget {
  const ObraDescPage({super.key});

  @override
  State<ObraDescPage> createState() => _ObraDescPageState();
}

class _ObraDescPageState extends State<ObraDescPage> {
  late Future<Map<String, dynamic>?> _future;
  final List<Widget> _pages = [
    const MyHomePage(),
    const HistoryPage(),
    const SavedPage(),
    const ConfigPage(),
  ];

  @override
  void initState() {
    super.initState();

    // The id will be initialized in the build method
  }

  Future<Map<String, dynamic>?> _fetchImageUrl(String id) async {
    final response = await supabase
        .from('Obras')
        .select('*')
        .eq('id', id)
        .single();
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final String id = (ModalRoute.of(context)?.settings.arguments as int).toString();

    // Initialize the future in the build method
    _future = _fetchImageUrl(id);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        foregroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data found'));
          }

          final imageUrl = snapshot.data?['ImageUrl'];
          final obraName = snapshot.data?['Name'];
          final obraDesc = snapshot.data?['DescOb'];
          final obraGenres = snapshot.data?['genres'];

          return Stack(
            children: [
              // Imagem de fundo
              if (imageUrl != null)

                Positioned.directional(top: 0,
                  textDirection: TextDirection.ltr,
                  height: 260,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              Container(
                height: 260,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox.fromSize(size: const Size.fromHeight(100)),
                    if (imageUrl != null)
                      Column(
                        children: [
                          Container(
                            width: 150,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      const Text('Image URL not found', style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          obraName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Itim',
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          snapshot.data?['author'],
                          style: const TextStyle(color: Colors.grey, height: 1.5),
                        ),
                        const SizedBox(height: 12.0),
                        if (obraGenres != null)
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 10.0,
                            children: [
                              for (final genre in obraGenres)
                                Chip(
                                  label: Text(genre),
                                ),
                            ],
                          ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: SizedBox(
                            width: 350,
                            height: 170,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                obraDesc,
                                style: const TextStyle(color: Colors.grey, fontSize: 14.0),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ),
                        const Center(
                          child: Divider(
                            color: Colors.white,
                            indent: 100,
                            endIndent: 100,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                    const Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: [
                        Icon(CupertinoIcons.book_fill, color: Colors.white, size: 30.0),
                        Icon(CupertinoIcons.heart, color: Colors.white, size: 30.0),
                        Icon(CupertinoIcons.captions_bubble, color: Colors.white, size: 30.0),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    MyButton(
                      onTap: () => Navigator.pushNamed(context, 'pages/caps', arguments: id),
                      buttonText: 'Ler',
                      width: 170.0,
                      height: 60.0,
                      colorAway: Colors.white,
                      colorPressed: Colors.black,
                      borderColorAway: Colors.black,
                      borderColorPressed: Colors.white,
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
