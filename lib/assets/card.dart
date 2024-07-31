import 'package:flutter/material.dart';

class MangaCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String badge;
  final String desc;
  final double textPadding;
  final double textSize;
  final int id;
  final int views;
  final List<dynamic> obraGenres;

  const MangaCard({
    Key? key,
    required this.id,
    this.textPadding = 0,
    required this.imageUrl,
    this.title = '',
    this.textSize = 0,
    this.badge = '',
    required this.desc,
    required this.obraGenres,
    required this.views,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'pages/desc', arguments: id);
        // Use route name string
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Image.network(
                imageUrl.isNotEmpty
                    ? imageUrl
                    : 'https://lermangas.me/wp-content/uploads/2024/02/nossa-alianca-secreta.jpg',
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(1, 8, 0, 2),
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.white),
                maxLines: 1, // Limita a uma linha
                overflow: TextOverflow.ellipsis, // Adiciona "..." se o texto for muito longo
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                obraGenres.isNotEmpty ? obraGenres[0] : '',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.visibility, color: Colors.grey, size: 14),
                      const SizedBox(width: 4),
                      Text('$views', style: const TextStyle(color: Colors.white, fontSize: 10)),
                    ],
                  ),
              ),
          ],
        ),
      ),
    );
  }
}
