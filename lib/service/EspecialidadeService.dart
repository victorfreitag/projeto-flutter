import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_go/model/Especialidade.dart';

class EspecialidadeService {
  static const String baseUrl = 'http://192.168.56.1:8080/especialidade/';

  Future<List<Especialidade>> buscarEspecialidade() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic especialidade) => Especialidade.fromJson(especialidade)).toList();
    } else {
      throw Exception('Falha ao carregar especialidades');
    }
  }

  Future<void> criarEspecialidade(Especialidade especialidade) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(especialidade.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Falha ao criar especialidade');
    }
  }

  Future<void> atualizarEspecialidade(Especialidade especialidade) async {
    final response = await http.put(
      Uri.parse('$baseUrl${especialidade.id_especialidades}'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(especialidade.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar especialidaades');
    }
  }

  Future<void> deletarEspecialidade(int id_especialidades) async {
    final response = await http.delete(Uri.parse('$baseUrl$id_especialidades'));
    if (response.statusCode == 204) {
      print('Especialidade deletado com sucesso');
    } else {
      print('Erro ao deletar especialidade: ${response.statusCode} ${response.body}');
      throw Exception('Falha ao deletar especialidade');
    }
  }
}
