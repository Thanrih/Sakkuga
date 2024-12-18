import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        foregroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/pt/9/98/Vagabond1.jpg', scale: 1.5),
            ),
            const SizedBox(height: 10),
            const Text(
              'E-mail',
              style: TextStyle(color: Colors.white),
            ),
            const Divider(color: Colors.grey),
            ListTile(
              title: const Text('Alterar Imagem de Perfil', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Ação ao tocar na opção
              },
            ),
            ListTile(
              title: const Text('Alterar Apelido', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Ação ao tocar na opção
              },
            ),
            ListTile(
              title: const Text('Alterar E-mail', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Ação ao tocar na opção
              },
            ),
            ListTile(
              title: const Text('Alterar Senha', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Ação ao tocar na opção
              },
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              title: const Text('Linguagem', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Ação ao tocar na opção
              },
            ),
            ListTile(
              title: const Text('Limpar Cache', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Ação ao tocar na opção
              },
            ),
            ListTile(
              title: const Text('Display', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Ação ao tocar na opção
              },
            ),
            ElevatedButton(
              onPressed: () {
                Supabase.instance.client.auth.signOut();
                print('User logged out successfully.');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 40),
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'Quit',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
