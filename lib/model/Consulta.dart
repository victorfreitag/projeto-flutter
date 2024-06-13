class Consulta {
  final int? id_consulta;
  final String data;
  final String horario;
  final String descricao;




  Consulta({
    this.id_consulta,
    required this.data,
    required this.horario,
    required this.descricao,
  });

  factory Consulta.fromJson(Map<String, dynamic> json) {
    return Consulta(
      id_consulta: json['id_consulta'],
      data: json['data'],
      horario: json['horario'],
      descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_consulta': id_consulta,
      'data': data,
      'horario': horario,
      'descricao': descricao,

    };
  }
}
