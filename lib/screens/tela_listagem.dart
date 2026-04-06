import 'package:flutter/material.dart';
import '../models/livro.dart';
import 'tela_detalhes.dart';
import 'tela_formulario.dart';
import 'tela_generos.dart';

// tela principal - stateful pq a lista de livros muda
class TelaListagem extends StatefulWidget {
  const TelaListagem({super.key});

  @override
  State<TelaListagem> createState() => _TelaListagemState();
}

class _TelaListagemState extends State<TelaListagem> {
  // lista vazia, o usuario vai adicionando
  final List<Livro> _livros = [];

  // lista de generos que o usuario pode gerenciar
  List<String> _generos = [
    'Romance', 'Fantasia', 'Ficcao Cientifica', 'Terror',
    'Aventura', 'Biografia', 'Autoajuda', 'Fabula', 'Poesia', 'Outro',
  ];

  int _proximoId = 1;

  // abre a tela de generos pra gerenciar
  void _gerenciarGeneros() async {
    final generosAtualizados = await Navigator.push<List<String>>(
      context,
      MaterialPageRoute(builder: (context) => TelaGeneros(generos: _generos)),
    );
    if (generosAtualizados != null) {
      setState(() { _generos = generosAtualizados; });
    }
  }

  // abre o formulario vazio e espera o usuario preencher
  void _adicionarLivro() async {
    final novoLivro = await Navigator.push<Livro>(
      context,
      MaterialPageRoute(builder: (context) => TelaFormulario(generos: _generos)),
    );
    // se o usuario salvou (nao apertou voltar), adiciona na lista
    if (novoLivro != null) {
      setState(() {
        _livros.add(Livro(
          id: _proximoId++,
          titulo: novoLivro.titulo,
          autor: novoLivro.autor,
          paginas: novoLivro.paginas,
          genero: novoLivro.genero,
          lido: novoLivro.lido,
        ));
      });
      _mostrarMensagem('"${novoLivro.titulo}" adicionado!', Colors.green);
    }
  }

  // abre o formulario ja preenchido com os dados do livro
  void _editarLivro(int index) async {
    final livroEditado = await Navigator.push<Livro>(
      context,
      MaterialPageRoute(builder: (context) => TelaFormulario(livro: _livros[index], generos: _generos)),
    );
    if (livroEditado != null) {
      setState(() {
        _livros[index].titulo = livroEditado.titulo;
        _livros[index].autor = livroEditado.autor;
        _livros[index].paginas = livroEditado.paginas;
        _livros[index].genero = livroEditado.genero;
        _livros[index].lido = livroEditado.lido;
      });
      _mostrarMensagem('"${livroEditado.titulo}" editado!', Colors.blue);
    }
  }

  // pergunta se quer mesmo excluir antes de remover
  void _excluirLivro(int index) {
    final livro = _livros[index];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2C1810),
        title: const Text('Excluir livro?', style: TextStyle(color: Colors.white)),
        content: Text('Deseja excluir "${livro.titulo}"?', style: const TextStyle(color: Colors.grey)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() { _livros.removeAt(index); });
              Navigator.pop(ctx);
              _mostrarMensagem('"${livro.titulo}" excluido!', Colors.red);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Excluir', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // abre a tela com todas as infos do livro
  void _verDetalhes(Livro livro) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TelaDetalhes(livro: livro)));
  }

  // mostra aquela barrinha de mensagem la embaixo
  void _mostrarMensagem(String texto, Color cor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(texto), backgroundColor: cor, behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Livros'),
        actions: [
          // botao pra abrir a tela de generos
          IconButton(
            icon: const Icon(Icons.label),
            tooltip: 'Gerenciar Generos',
            onPressed: _gerenciarGeneros,
          ),
        ],
      ),
      // se nao tem livro nenhum mostra mensagem, senao mostra a lista
      body: _livros.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book_outlined, size: 80, color: Colors.grey[700]),
                  const SizedBox(height: 16),
                  Text('Nenhum livro cadastrado', style: TextStyle(fontSize: 18, color: Colors.grey[500])),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _livros.length,
              itemBuilder: (context, index) {
                final livro = _livros[index];
                // cada livro vira um card clicavel
                return Card(
                  color: const Color(0xFF2C1810),
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    onTap: () => _verDetalhes(livro),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // icone do livro na esquerda
                          Container(
                            width: 50, height: 65,
                            decoration: BoxDecoration(
                              color: const Color(0xFF8B4513).withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.book, color: Color(0xFFD4A574), size: 30),
                          ),
                          const SizedBox(width: 16),
                          // titulo, autor e genero no meio
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(livro.titulo, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                const SizedBox(height: 4),
                                Text(livro.autor, style: TextStyle(fontSize: 13, color: Colors.grey[400])),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    // tag do genero
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF8B4513).withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(livro.genero, style: const TextStyle(fontSize: 11, color: Color(0xFFD4A574))),
                                    ),
                                    const SizedBox(width: 8),
                                    // indicador se ja leu ou nao
                                    Icon(livro.lido ? Icons.check_circle : Icons.schedule, size: 14, color: livro.lido ? Colors.green : Colors.orange),
                                    const SizedBox(width: 4),
                                    Text(livro.lido ? 'Lido' : 'Pendente', style: TextStyle(fontSize: 11, color: livro.lido ? Colors.green : Colors.orange)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // botoes de editar e excluir na direita
                          Column(
                            children: [
                              IconButton(icon: const Icon(Icons.edit, color: Colors.blue, size: 20), onPressed: () => _editarLivro(index)),
                              IconButton(icon: const Icon(Icons.delete, color: Colors.red, size: 20), onPressed: () => _excluirLivro(index)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      // botao flutuante pra adicionar livro novo
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarLivro,
        backgroundColor: const Color(0xFF8B4513),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}