import 'package:flutter/material.dart';


class Profile extends StatelessWidget {

  const Profile ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(title: const Text('Profile')),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person_2_rounded,
                  color: Colors.white),
            ],
          )
        ],
      ),
    );

  }
}