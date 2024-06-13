class Especialidade {
  final int? id_especialidades;
  final String nome;

  Especialidade({this.id_especialidades, required this.nome});

  factory Especialidade.fromJson(Map<String, dynamic> json) {
    return Especialidade(
      id_especialidades: json['id_especialidades'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id_especialidades,
      'nome': nome,
    };
  }
}
