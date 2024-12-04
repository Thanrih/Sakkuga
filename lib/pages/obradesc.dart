import 'dart:ui';
import 'package:like_button/like_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakugaacaptors/assets/button/button_viewmodel.dart';
import 'package:sakugaacaptors/assets/button/my_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class ObraDescPage extends StatefulWidget {
  const ObraDescPage({super.key});

  @override
  State<ObraDescPage> createState() => _ObraDescPageState();
}

class _ObraDescPageState extends State<ObraDescPage> {
  late Future<Map<String, dynamic>?> _future;

  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>?> _fetchImageUrl(String id) async {
    final response = await supabase
        .from('Obras')
        .select('*')
        .eq('id', id)
        .single();
    return response;
  }

  Future<bool> _insertObra(String id) async {
    final userId = supabase.auth.currentUser ?.id;

    if (userId == null) {
      print('Usuário não autenticado');
      return false; // Return false if the user is not authenticated
    }

    final response = await supabase
        .from('Obras Curtidas')
        .insert({
      'id': id,
      'userId': userId,
    });
    if (response.error != null) {
      print('Error inserting obra: ${response.error!.message}');
      return false; // Return false in case of error
    } else {
      print('Obra inserida com sucesso!');
      return true; // Return true in case of success
    }
  }

  @override
  Widget build(BuildContext context) {
    final String id = (ModalRoute.of(context)?.settings.arguments as int).toString();
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
              if (imageUrl != null)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 260,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
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
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                width: double .infinity,
                                height: double.infinity,
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
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 200,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                obraDesc,
                                style: const TextStyle(color: Colors.grey, fontSize: 14.0),
                                textAlign: TextAlign.center,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(CupertinoIcons.book_fill, color: Colors.white, size: 30.0),
                        const SizedBox(width: 10,),
                        LikeButton(
                          onTap: (isLiked) async {
                            final success = await _insertObra(id);
                            return success; // Return the result of the insertion
                          },
                          bubblesColor: const BubblesColor(dotPrimaryColor: Colors.red, dotSecondaryColor: Colors.red),
                          size: 30,
                        ),
                        const SizedBox(width: 10,),
                        const Icon(CupertinoIcons.captions_bubble, color: Colors.white, size: 30.0),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    MyButton(
                      viewModel: ButtonViewModel(
                        onTap: () => Navigator.pushNamed(context, 'pages/caps', arguments: id), // Pass the navigation function directly
                        buttonText: 'Ler', // Updated button text
                        width: 150,
                        height: 70,
                        colorAway: Colors.white,
                        colorPressed: Colors.black,
                        borderColorAway: Colors.black,
                        borderColorPressed: Colors.white,
                      ),
                    ),
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