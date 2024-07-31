import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sakugaacaptors/assets/carrousselImages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sakugaacaptors/assets/card.dart';
import 'login.dart';
import 'package:horizontal_list_view/horizontal_list_view.dart';

final supabase = Supabase.instance.client;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Map<String, dynamic>>> _data() async {
    final response = await supabase.from('Obras').select('*');
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Container(
              decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.darken,
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.3),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _data(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No images found');
                } else {
                  final dataList = snapshot.data!.sublist(0, 3); // Peguei os primeiros 3 itens da lista

                  return CarouselSlider(
                    items: dataList.map((data) {
                      return Stack(
                        children: [
                          CarousselImage(
                            imageUrl: data['ImageUrl'],
                            title: '',
                            textSize: 0,
                            desc: '',
                            id: data['id'],
                          ),
                        ],
                      );
                    }).toList(),
                    options: CarouselOptions(
                      // Suas opções do Carousel
                      autoPlay: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration: const Duration(milliseconds: 500),
                      height: 400,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      enlargeCenterPage: false,
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(8.0,0,0,0),
                  child: Text('Novos', style: TextStyle(fontSize: 20, color: Colors.white,)),
                ),
                Icon(Icons.chevron_right, color: Colors.white),
              ],
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _data(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No images found');
                } else {
                  final dataList = snapshot.data!.sublist(0, 5);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 200,
                      child: HorizontalListView(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        children: dataList.map((data) {
                          return MangaCard(
                            imageUrl: data['ImageUrl'],
                            title: data['Name'],
                            textSize: 16,
                            textPadding: 0,
                            desc: '',
                            id: data['id'],
                            obraGenres: data['genres'],
                            views: data['views'],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(8.0,0,0,0),
                  child: Text('Mais lidos', style: TextStyle(fontSize: 20, color: Colors.white,)),
                ),
                Icon(Icons.chevron_right, color: Colors.white),
              ],
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _data(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.fromLTRB(0,200,0,200),
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No images found');
                } else {
                  final dataList = snapshot.data!
                    ..sort((a, b) => b['views'].compareTo(a['views'])); // Ordena a lista por 'views'

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 200,
                      child: HorizontalListView(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        children: dataList.map((data) {
                          return MangaCard(
                            imageUrl: data['ImageUrl'],
                            title: data['Name'],
                            textSize: 15,
                            textPadding: 20,
                            desc: '',
                            id: data['id'],
                            obraGenres: data['genres'],
                            views: data['views'],
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
