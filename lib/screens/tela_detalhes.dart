  import 'package:flutter/material.dart';
import '../models/livro.dart';

// mostra as infos completas de um livro - stateless pq so exibe dados
class TelaDetalhes extends StatelessWidget {
  final Livro livro; // recebe o livro que foi clicado

  const TelaDetalhes({super.key, required this.livro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Livro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // capa fake do livro
            Center(
              child: Container(
                width: 120, height: 160,
                decoration: BoxDecoration(
                  color: const Color(0xFF8B4513).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFD4A574).withOpacity(0.5)),
                ),
                child: const Icon(Icons.menu_book, size: 60, color: Color(0xFFD4A574)),
              ),
            ),
            const SizedBox(height: 24),

            // titulo centralizado
            Center(
              child: Text(
                livro.titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),

            // nome do autor
            Center(
              child: Text('por ${livro.autor}', style: TextStyle(fontSize: 16, color: Colors.grey[400])),
            ),
            const SizedBox(height: 8),

            // badge mostrando se ja leu ou nao
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: livro.lido ? Colors.green.withOpacity(0.15) : Colors.orange.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(livro.lido ? Icons.check_circle : Icons.schedule, size: 16, color: livro.lido ? Colors.green : Colors.orange),
                    const SizedBox(width: 6),
                    Text(livro.lido ? 'Ja lido' : 'Quero ler', style: TextStyle(color: livro.lido ? Colors.green : Colors.orange, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // secao de informacoes
            const Text('Informacoes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD4A574))),
            const SizedBox(height: 16),

            // card com os dados
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2C1810),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _linhaInfo(Icons.person, 'Autor', livro.autor),
                  const Divider(color: Colors.grey, height: 24),
                  _linhaInfo(Icons.category, 'Genero', livro.genero),
                  const Divider(color: Colors.grey, height: 24),
                  _linhaInfo(Icons.description, 'Paginas', '${livro.paginas} paginas'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // monta uma linha com icone + rotulo + valor
  Widget _linhaInfo(IconData icone, String rotulo, String valor) {
    return Row(
      children: [
        Icon(icone, color: const Color(0xFFD4A574), size: 20),
        const SizedBox(width: 12),
        Text('$rotulo:', style: TextStyle(fontSize: 14, color: Colors.grey[500])),
        const SizedBox(width: 8),
        Expanded(
          child: Text(valor, style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}
