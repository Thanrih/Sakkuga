import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {

  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        foregroundColor: Colors.transparent,
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CupertinoSearchTextField(
        ),
      ),
    );

  }
}

