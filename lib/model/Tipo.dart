class Tipo {
  final int? id_tipo;
  final String nome;

  Tipo({this.id_tipo, required this.nome});

  factory Tipo.fromJson(Map<String, dynamic> json) {
    return Tipo(
      id_tipo: json['id_tipo'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_tipo': id_tipo,
      'nome': nome,
    };
  }
}
