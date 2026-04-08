import 'package:flutter/material.dart';

// tela pra gerenciar os generos - stateful pq a lista muda
class TelaGeneros extends StatefulWidget {
  final List<String> generos;

  const TelaGeneros({super.key, required this.generos});

  @override
  State<TelaGeneros> createState() => _TelaGenerosState();
}

class _TelaGenerosState extends State<TelaGeneros> {
  late List<String> _generos;

  @override
  void initState() {
    super.initState();
    // copia a lista pra poder mexer sem afetar a original ate salvar
    _generos = List.from(widget.generos);
  }

  // adiciona um genero novo
  void _adicionarGenero() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2C1810),
        title: const Text('Novo Genero', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Nome do genero',
            hintStyle: TextStyle(color: Colors.grey[600]),
            filled: true,
            fillColor: const Color(0xFF1A1A1A),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final nome = controller.text.trim();
              if (nome.isNotEmpty && !_generos.contains(nome)) {
                setState(() { _generos.add(nome); });
              }
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B4513)),
            child: const Text('Adicionar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // edita o nome de um genero
  void _editarGenero(int index) {
    final controller = TextEditingController(text: _generos[index]);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2C1810),
        title: const Text('Editar Genero', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF1A1A1A),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final nome = controller.text.trim();
              if (nome.isNotEmpty) {
                setState(() { _generos[index] = nome; });
              }
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B4513)),
            child: const Text('Salvar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // exclui um genero com confirmacao
  void _excluirGenero(int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2C1810),
        title: const Text('Excluir genero?', style: TextStyle(color: Colors.white)),
        content: Text('Remover "${_generos[index]}"?', style: const TextStyle(color: Colors.grey)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() { _generos.removeAt(index); });
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Excluir', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generos'),
        // botao pra salvar e voltar
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => Navigator.pop(context, _generos),
          ),
        ],
      ),
      body: _generos.isEmpty
          ? Center(
              child: Text('Nenhum genero cadastrado', style: TextStyle(fontSize: 16, color: Colors.grey[500])),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              itemCount: _generos.length,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color(0xFF2C1810),
                  margin: const EdgeInsets.only(bottom: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const Icon(Icons.label, color: Color(0xFFD4A574)),
                    title: Text(_generos[index], style: const TextStyle(color: Colors.white)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(icon: const Icon(Icons.edit, color: Colors.blue, size: 20), onPressed: () => _editarGenero(index)),
                        IconButton(icon: const Icon(Icons.delete, color: Colors.red, size: 20), onPressed: () => _excluirGenero(index)),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarGenero,
        backgroundColor: const Color(0xFF8B4513),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}