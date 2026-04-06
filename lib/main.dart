import 'package:flutter/material.dart';
import 'screens/tela_inicial.dart';

// funcao principal que inicia o app
void main() {
  runApp(const MinhaBibliotecaApp());
}

// widget raiz do app - stateless pq so configura o tema
class MinhaBibliotecaApp extends StatelessWidget {
  const MinhaBibliotecaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Biblioteca',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B4513), // marrom estilo couro de livro
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2C1810),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const TelaInicial(), // primeira tela que aparece
    );
  }
}