import 'package:flutter/material.dart';
import '../models/livro.dart';

// formulario pra adicionar ou editar livro - stateful pq os campos mudam
class TelaFormulario extends StatefulWidget {
  final Livro? livro; // se vier null eh novo, se vier preenchido eh edicao
  final List<String> generos; // lista de generos disponiveis

  const TelaFormulario({super.key, this.livro, required this.generos});

  @override
  State<TelaFormulario> createState() => _TelaFormularioState();
}

class _TelaFormularioState extends State<TelaFormulario> {
  final _formKey = GlobalKey<FormState>();

  // controladores dos campos de texto
  late TextEditingController _tituloController;
  late TextEditingController _autorController;
  late TextEditingController _paginasController;

  String _generoSelecionado = '';
  bool _lido = false;

  @override
  void initState() {
    super.initState();
    // se ta editando, preenche os campos com os dados atuais
    if (widget.livro != null) {
      _tituloController = TextEditingController(text: widget.livro!.titulo);
      _autorController = TextEditingController(text: widget.livro!.autor);
      _paginasController = TextEditingController(text: widget.livro!.paginas.toString());
      _generoSelecionado = widget.livro!.genero;
      _lido = widget.livro!.lido;
    } else {
      // se eh novo, campos vazios
      _tituloController = TextEditingController();
      _autorController = TextEditingController();
      _paginasController = TextEditingController();
      // pega o primeiro genero da lista como padrao
      _generoSelecionado = widget.generos.isNotEmpty ? widget.generos.first : '';
    }
  }

  @override
  void dispose() {
    // limpa os controladores quando sai da tela
    _tituloController.dispose();
    _autorController.dispose();
    _paginasController.dispose();
    super.dispose();
  }

  // valida e manda o livro de volta pra tela anterior
  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final livro = Livro(
        id: 0,
        titulo: _tituloController.text.trim(),
        autor: _autorController.text.trim(),
        paginas: int.parse(_paginasController.text.trim()),
        genero: _generoSelecionado,
        lido: _lido,
      );
      Navigator.pop(context, livro);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool editando = widget.livro != null;

    return Scaffold(
      appBar: AppBar(title: Text(editando ? 'Editar Livro' : 'Novo Livro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // campo titulo
              TextFormField(
                controller: _tituloController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Titulo do livro',
                  prefixIcon: const Icon(Icons.book, color: Color(0xFFD4A574)),
                  filled: true, fillColor: const Color(0xFF2C1810),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) return 'Informe o titulo';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // campo autor
              TextFormField(
                controller: _autorController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Autor',
                  prefixIcon: const Icon(Icons.person, color: Color(0xFFD4A574)),
                  filled: true, fillColor: const Color(0xFF2C1810),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) return 'Informe o autor';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // campo paginas (so aceita numero)
              TextFormField(
                controller: _paginasController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Numero de paginas',
                  prefixIcon: const Icon(Icons.description, color: Color(0xFFD4A574)),
                  filled: true, fillColor: const Color(0xFF2C1810),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) return 'Informe as paginas';
                  if (int.tryParse(valor.trim()) == null) return 'Numero invalido';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // dropdown de genero (usa a lista que veio da tela de listagem)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(color: const Color(0xFF2C1810), borderRadius: BorderRadius.circular(12)),
                child: DropdownButtonFormField<String>(
                  value: _generoSelecionado,
                  dropdownColor: const Color(0xFF2C1810),
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Genero',
                    prefixIcon: Icon(Icons.category, color: Color(0xFFD4A574)),
                    border: InputBorder.none,
                  ),
                  items: widget.generos.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                  onChanged: (valor) { setState(() { _generoSelecionado = valor!; }); },
                ),
              ),
              const SizedBox(height: 16),

              // switch de lido/nao lido
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: const Color(0xFF2C1810), borderRadius: BorderRadius.circular(12)),
                child: SwitchListTile(
                  title: const Text('Ja leu este livro?', style: TextStyle(color: Colors.white)),
                  subtitle: Text(_lido ? 'Sim, ja li' : 'Ainda nao li', style: TextStyle(color: _lido ? Colors.green : Colors.orange)),
                  value: _lido,
                  activeColor: const Color(0xFF8B4513),
                  onChanged: (valor) { setState(() { _lido = valor; }); },
                ),
              ),
              const SizedBox(height: 32),

              // botao salvar
              ElevatedButton(
                onPressed: _salvar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B4513),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  editando ? 'SALVAR ALTERACOES' : 'ADICIONAR LIVRO',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}