import 'package:flutter/material.dart';
import 'package:sakugaacaptors/assets/card/card_viewmodel.dart';

class MangaCard extends StatelessWidget {
  final MangaViewModel viewModel;

  const MangaCard({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'pages/desc', arguments: viewModel.id);
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
                viewModel.imageUrl.isNotEmpty
                    ? viewModel.imageUrl
                    : 'https://lermangas.me/wp-content/uploads/2024/02/nossa-alianca-secreta.jpg',
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(1, 8, 0, 2),
              child: Text(
                viewModel.title,
                style: const TextStyle(fontSize: 16, color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                viewModel.firstGenre,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.visibility, color: Colors.grey, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    '${viewModel.views}',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}