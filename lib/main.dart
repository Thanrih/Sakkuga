import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sakugaacaptors/pages/caps.dart';
import 'package:sakugaacaptors/pages/history.dart';
import 'package:sakugaacaptors/pages/homepage.dart';
import 'package:sakugaacaptors/pages/login.dart';
import 'package:sakugaacaptors/pages/obradesc.dart';
import 'package:sakugaacaptors/pages/register.dart';
import 'package:sakugaacaptors/pages/saved.dart';
import 'package:sakugaacaptors/pages/settings.dart';
import 'package:sakugaacaptors/providers/provider_favorites.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sakugaacaptors/pages/reading.dart';
import 'package:sakugaacaptors/pages/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Conexão com o Supabase
  await Supabase.initialize(
    url: 'https://xyewkeuvgrephjahsjds.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh5ZXdrZXV2Z3JlcGhqYWhzamRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQxMzYyNTQsImV4cCI6MjAyOTcxMjI1NH0.nPl6lx6KEUKtScJGPBanQBui5MmZtLHtdYJbJRyY2Fo',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// Classe principal do app
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

// Classe que contém o estado do app
class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  // Lista de páginas mapeadas pela navbar
  final List<Widget> _pages = [
    const MyHomePage(),
    const HistoryPage(),
    const SavedPage(),
    const ConfigPage(),
  ];

  // Altera o estado da navbar quando um item for selecionado
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sakuga Captors',
      home: Scaffold(
        // Cria a navbar
        body: _pages[_currentIndex],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(color: Colors.white),
            ),
          ),
          child: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: _onItemTapped,
            indicatorColor: Colors.white,
            backgroundColor: Colors.black,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home, color: Colors.white),
                selectedIcon: Icon(Icons.home, color: Colors.black),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.history_edu_outlined, color: Colors.white),
                selectedIcon: Icon(Icons.history_edu_outlined, color: Colors.black),
                label: 'Histórico',
              ),
              NavigationDestination(
                icon: Icon(Icons.save, color: Colors.white),
                selectedIcon: Icon(Icons.save, color: Colors.black),
                label: 'Salvos',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings, color: Colors.white),
                selectedIcon: Icon(Icons.settings, color: Colors.black),
                label: 'Configurações',
              ),
            ],
          ),
        ),
      ),
      routes: {
        'pages/home': (context) => const MyHomePage(),
        'pages/history': (context) => const HistoryPage(),
        'pages/saved': (context) => const SavedPage(),
        'pages/config': (context) => const ConfigPage(),
        'pages/desc': (context) => const ObraDescPage(),
        'pages/obra': (context) => const ReadingPage(),
        'pages/profile': (context) => const Profile(),
        'pages/login': (context) => LoginPage(),
        'pages/register': (context) => RegisterPage(),
        'pages/caps': (context) => const Caps(),
      },
    );
  }
}
