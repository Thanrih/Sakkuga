import 'package:flutter/material.dart';
import 'package:sakugaacaptors/assets/my_button.dart';
import 'package:sakugaacaptors/assets/my_textfield.dart';
import 'package:sakugaacaptors/assets/square.dart';
import '../main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //text controllers
  final emailControler = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    void userSignIn(){
      supabase.auth.signInWithPassword(password: passwordController.text, email: emailControler.text).then((value){});
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 0),
                  child: const Text('Login', style: TextStyle(
                  color: Colors.black54,
                  fontSize: 25,
              ),
              )),

              //icone de fechadura
              Image.network('https://xyewkeuvgrephjahsjds.supabase.co/storage/v1/object/public/Icons/WhatsApp_Image_2024-05-06_at_21.10_2.png?t=2024-06-02T14%3A46%3A34.634Z',
                  height: 200),
              Text(
                'Seja bem-vindo!',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              //nome
              MyTextField(controller: emailControler,obscureText: false,hintText: 'E-mail',),//username
              const SizedBox(height: 25),
              //senha
              MyTextField(controller: passwordController,obscureText: true,hintText: 'Senha',),//password
              const SizedBox(height: 10),
              //esqueceu a senha?
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
                  onTap: userSignIn, buttonText: 'Login', width: 150, height: 70, colorAway: Colors.white, colorPressed: Colors.black, borderColorAway: Colors.black, borderColorPressed: Colors.white,),
              const SizedBox(height: 10),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal:25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color:  Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Ou continue com',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ))
                  ],
                ),
              ),
              //google e apple
              /*const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(imagePath: 'https://cdn4.iconfinder.com/data/icons/logos-brands-7/512/google_logo-google_icongoogle-512.png'),
                  SizedBox(width:10),
                  SquareTile(imagePath: 'https://cdn3.iconfinder.com/data/icons/picons-social/57/16-apple-512.png')
                ],
              ),*/
              SizedBox.fromSize(child: const SizedBox(height: 30)),
              ElevatedButton(
                onPressed: () {
                  // Handle button press action (e.g., navigate to registration page)
                  Navigator.pushNamed(context, 'pages/register');
                },
                style: ElevatedButton.styleFrom(

                  minimumSize: const Size(200, 40), backgroundColor: Colors.transparent, // Set button background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Add rounded corners
                  ),
                ),
                child: const Text(
                  'Registre-se',
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),            ],
          ),
        ),
      ),
    );
  }
}