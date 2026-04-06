 // classe que representa um livro da biblioteca
class Livro {
  final int id;
  String titulo;
  String autor;
  int paginas;
  String genero;
  bool lido;

  Livro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.paginas,
    required this.genero,
    this.lido = false, // por padrao o livro começa como nao lido
  });
}
