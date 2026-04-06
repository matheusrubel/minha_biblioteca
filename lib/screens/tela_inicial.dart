  import 'package:flutter/material.dart';
import 'tela_listagem.dart';

// tela de boas vindas - stateless pq nada muda aqui
class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        // gradiente de fundo escuro
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2C1810), Color(0xFF1A1A1A)],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // icone grande de livro
              const Icon(Icons.menu_book_rounded, size: 100, color: Color(0xFFD4A574)),
              const SizedBox(height: 24),

              // titulo do app
              const Text(
                'Minha Biblioteca',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              Text(
                'Organize sua colecao de livros',
                style: TextStyle(fontSize: 16, color: Colors.grey[400]),
              ),

              const SizedBox(height: 40),

              // caixa mostrando as funcionalidades do app
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Adicione, visualize, edite e exclua\nseus livros favoritos!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.grey[300]),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _iconeFunc(Icons.add, 'Adicionar'),
                          _iconeFunc(Icons.edit, 'Editar'),
                          _iconeFunc(Icons.visibility, 'Ver'),
                          _iconeFunc(Icons.delete, 'Excluir'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(flex: 2),

              // botao pra entrar no app
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // navega pra tela de listagem
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TelaListagem()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B4513),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      'ENTRAR',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  // monta o iconezinho com texto embaixo
  static Widget _iconeFunc(IconData icone, String texto) {
    return Column(
      children: [
        Icon(icone, color: const Color(0xFFD4A574), size: 22),
        const SizedBox(height: 4),
        Text(texto, style: TextStyle(fontSize: 11, color: Colors.grey[400])),
      ],
    );
  }
}
