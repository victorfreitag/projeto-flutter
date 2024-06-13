class Pet {
  final int? id_pet;
  final String nome;
  final String data_nasc;
  final String num_documento;
  final String raca;
  final String cor;



  Pet({
    this.id_pet,
    required this.nome,
    required this.data_nasc,
    required this.num_documento,
    required this.raca,
    required this.cor,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id_pet: json['id'],
      nome: json['nome'],
      data_nasc: json['data_nasc'],
      num_documento: json['num_documento'],
      raca: json['raca'],
      cor: json['cor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id_pet,
      'nome': nome,
      'data_nasc': data_nasc,
      'num_documento': num_documento,
      'raca': raca,
      'cor': cor,

    };
  }
}
