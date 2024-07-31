import 'package:flutter/material.dart';

class CarousselImage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String badge;
  final String desc;
  final double textPadding;
  final double textSize;
  final int id;

  const CarousselImage({
    Key? key,
    required this.id,
    this.textPadding = 0,
    required this.imageUrl,
    this.title = '',
    this.textSize = 0,
    this.badge = '',
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'pages/desc', arguments: id);
        // Use route name string
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              color: Colors.transparent,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover, // Ensure image fills container
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(textPadding), // Apply text padding
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}