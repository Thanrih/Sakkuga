import 'package:flutter/material.dart';
import 'package:sakugaacaptors/assets/button/button_viewmodel.dart';
import 'package:sakugaacaptors/assets/button/my_button.dart';
import 'package:sakugaacaptors/assets/textfield/my_textfield.dart';
import 'package:sakugaacaptors/pages/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  // Text controllers
  final emailControler = TextEditingController();
  final passwordController = TextEditingController();
  final confpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void userSignIn() async {
      if (passwordController.text == confpasswordController.text) {
        if (passwordController.text.length > 5) {
          try {
            // Realiza o registro com Supabase
            await supabase.auth.signUp(
              password: passwordController.text,
              email: emailControler.text,
            );

            // Exibe mensagem de sucesso
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Registro realizado com sucesso!'),
                  content: const Text('Você pode fazer login agora.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Fecha o diálogo
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  LoginPage()),
                        );
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          } catch (error) {
            // Mostra erro caso o registro falhe
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Erro ao registrar'),
                  content: Text(error.toString()), // Exibe mensagem de erro
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Fecha o diálogo
                      },
                      child: const Text('Fechar'),
                    ),
                  ],
                );
              },
            );
          }
        } else {
          // Mensagem de erro para senhas curtas
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Erro de senha'),
                content: const Text('A senha deve ter mais de 5 caracteres.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Fecha o diálogo
                    },
                    child: const Text('Fechar'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        // Mensagem de erro para senhas que não coincidem
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro de confirmação'),
              content: const Text('A senha não coincide com a confirmação.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Fecha o diálogo
                  },
                  child: const Text('Fechar'),
                ),
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(color: Colors.white),
      foregroundColor: Colors.transparent,
    ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(
                  'https://xyewkeuvgrephjahsjds.supabase.co/storage/v1/object/public/Icons/WhatsApp_Image_2024-05-06_at_21.10_2.png?t=2024-06-02T14%3A46%3A34.634Z',
                  height: 200,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 0),
                  child: const Text(
                    'Registre-se',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    children: [
                      MyTextField(
                        controller: emailControler,
                        obscureText: false,
                        hintText: 'E-mail',
                      ),
                      const SizedBox(height: 25),
                      MyTextField(
                        controller: passwordController,
                        obscureText: true,
                        hintText: 'Senha',
                      ),
                      const SizedBox(height: 25),
                      MyTextField(
                        controller: confpasswordController,
                        obscureText: true,
                        hintText: 'Confirmar senha',
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
            MyButton(
              viewModel: ButtonViewModel(
                onTap: userSignIn, // Pass the navigation function directly
                buttonText: 'Registrar', // Updated button text
                width: 150,
                height: 70,
                colorAway: Colors.white,
                colorPressed: Colors.black,
                borderColorAway: Colors.black,
                borderColorPressed: Colors.white,
              ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
