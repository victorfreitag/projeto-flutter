class Proprietario {
  final int? id;
  final String nome;
  final String cpf;
  final String rua;
  final String bairro;
  final String cidade;
  final String telefone1;
  final String telefone2;




  Proprietario({
    this.id,
    required this.nome,
    required this.cpf,
    required this.rua,
    required this.bairro,
    required this.cidade,
    required this.telefone1,
    required this.telefone2,
    });

  factory Proprietario.fromJson(Map<String, dynamic> json) {
    return Proprietario(
      id: json['id'],
      nome: json['nome'],
      cpf: json['cpf'],
      rua: json['rua'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      telefone1: json['telefone1'],
      telefone2: json['telefone2'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_proprietario': id,
      'nome': nome,
      'cpf': cpf,
      'rua': rua,
      'bairro': bairro,
      'cidade': cidade,
      'telefone1': telefone1,
      'telefone2': telefone2,
    };
  }
}
