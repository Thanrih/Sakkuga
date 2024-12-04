import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sakugaacaptors/assets/button/button_viewmodel.dart';
import 'package:sakugaacaptors/assets/button/my_button.dart';
import 'package:sakugaacaptors/assets/textfield/my_textfield.dart';
import '../assets/square/square.dart';
import '../main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Verifica se o usuário já está logado

    void userSignIn() async {
      final email = emailController.text;
      final password = passwordController.text;

      // Verifica se os campos não estão vazios
      if (email.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CupertinoAlertDialog(
              title: Text('O campo de e-mail não pode estar vazio.'),
            );
          },
        );
        return;
      }

      if (password.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CupertinoAlertDialog(
              title: Text('O campo de senha não pode estar vazio.'),
            );
          },
        );
        return;
      }

      try {
        // Realiza o login com Supabase
        await supabase.auth.signInWithPassword(
          password: passwordController.text.trim(),
          email: emailController.text.trim(),
        );
        // Se o login for bem-sucedido, redireciona para a tela principal
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyApp()),
        );
      } catch (error) {
        // Mostra uma mensagem de erro caso o login falhe
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const CupertinoAlertDialog(
              title: Text('Erro ao fazer o login.'),
              content: Text('E-mail ou senha incorretos'),
            );
          },
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Deixa a cor de fundo transparente
        elevation: 0, // Remove a sombra da AppBar
        iconTheme: const IconThemeData(color: Colors.white), // Define a cor dos ícones
        toolbarOpacity: 1, // Define a opacidade da AppBar
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 3),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 25,
                    ),
                  ),
                ),
                // ícone de fechadura
                Image.asset('public/icons/icon.png',
                height: 200,
                ),
                Text(
                  'Seja bem-vindo!',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                // nome
                MyTextField(
                  controller: emailController,
                  obscureText: false,
                  hintText: 'E-mail',
                ), // username
                const SizedBox(height: 25),
                // senha
                MyTextField(
                  controller: passwordController,
                  obscureText: true,
                  hintText: 'Senha',
                ), // password
                const SizedBox(height: 10),
                // esqueceu a senha?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Esqueceu a senha?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
            MyButton(
              viewModel: ButtonViewModel(
                onTap: userSignIn, // Pass the userSignIn function directly
                buttonText: 'Login',
                width: 150,
                height: 70,
                colorAway: Colors.white,
                colorPressed: Colors.black,
                borderColorAway: Colors.black,
                borderColorPressed: Colors.white,
              ),
            ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                    
                      SizedBox(height: 50),
                    ],
                  ),
                ),
                // google e apple

                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press action (e.g., navigate to registration page)
                    Navigator.pushNamed(context, 'pages/register');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 40),
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Registre-se',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}