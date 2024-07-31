import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sakugaacaptors/assets/my_button.dart';
import 'package:sakugaacaptors/assets/my_textfield.dart';
import '../main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  //text controllers
  final emailControler = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    void userSignIn(){
      supabase.auth.signUp(password: passwordController.text, email: emailControler.text).then((value){});
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        foregroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image.network('https://xyewkeuvgrephjahsjds.supabase.co/storage/v1/object/public/Icons/WhatsApp_Image_2024-05-06_at_21.10_2.png?t=2024-06-02T14%3A46%3A34.634Z',
                  height: 200),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 0),

                  child: const Text('Registre-se', style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                  )),
              const SizedBox(height: 25),
              //nome
              MyTextField(controller: emailControler,obscureText: false,hintText: 'E-mail',),//username
              const SizedBox(height: 25),
              //senha
              MyTextField(controller: passwordController,obscureText: true,hintText: 'Senha',),//password
              const SizedBox(height: 25),
              MyTextField(controller: passwordController,obscureText: true,hintText: 'Confirmar senha',),//password

              const SizedBox(height: 25),
              MyButton(
                  onTap: userSignIn, buttonText: 'Finalizar', width: 150, height: 70,colorAway: Colors.white, colorPressed: Colors.black,borderColorAway: Colors.black, borderColorPressed: Colors.white),
              const SizedBox(height: 10),


              const Padding(
                padding: EdgeInsets.symmetric(horizontal:25.0),

              ),
              //google e apple

            ],
          ),
        ),
      ),
    );
  }
}