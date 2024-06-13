class Veterinario {
  final int? id;
  final String nome;
  final String cpf;
  final String rg;
  final String telefone1;
  final String telefone2;
  final String rua;
  final String bairro;
  final String cidade;
  final String crmv;






  Veterinario({
    this.id,
    required this.nome,
    required this.cpf,
    required this.rg,
    required this.telefone1,
    required this.telefone2,
    required this.rua,
    required this.bairro,
    required this.cidade,
    required this.crmv,
  });

  factory Veterinario.fromJson(Map<String, dynamic> json) {
    return Veterinario(
      id: json['id'],
      nome: json['nome'],
      cpf: json['cpf'],
      rg: json['rg'],
      telefone1: json['telefone1'],
      telefone2: json['telefone2'],
      rua: json['rua'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      crmv: json['crmv'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'rg': rg,
      'telefone1': telefone1,
      'telefone2': telefone2,
      'rua': rua,
      'bairro': bairro,
      'cidade': cidade,
      'crmv': crmv,


    };
  }
}
