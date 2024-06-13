import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_go/model/Consulta.dart';

class ConsultaService {
  static const String baseUrl = 'http://192.168.56.1:8080/consulta/';

  Future<List<Consulta>> buscarConsultas() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic consulta) => Consulta.fromJson(consulta)).toList();
    } else {
      throw Exception('Falha ao carregar especialidades');
    }
  }

  Future<void> criarConsulta(Consulta consulta) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(consulta.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Falha ao criar consulta');
    }
  }

  Future<void> atualizarConsulta(Consulta consulta) async {
    final response = await http.put(
      Uri.parse('$baseUrl${consulta.id_consulta}'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(consulta.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar consulta');
    }
  }

  Future<void> deletarConsulta(int id_consulta) async {
    final response = await http.delete(Uri.parse('$baseUrl$id_consulta'));
    if (response.statusCode == 204) {
      print('Consulta deletado com sucesso');
    } else {
      print('Erro ao deletar consulta: ${response.statusCode} ${response.body}');
      throw Exception('Falha ao deletar consulta');
    }
  }
}
