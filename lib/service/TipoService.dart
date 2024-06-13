import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_go/model/Tipo.dart';

class TipoService {
  static const String baseUrl = 'http://192.168.56.1:8080/tipo/';

  Future<List<Tipo>> buscarTipo() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Tipo.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar Tipo');
    }
  }

  Future<void> criarTipo(Tipo tipo) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(tipo.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Falha ao criar Tipo');
    }
  }

  Future<void> atualizarTipo(Tipo tipo) async {
    final response = await http.put(
      Uri.parse('$baseUrl${tipo.id_tipo}'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(tipo.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar tipo');
    }
  }

  Future<void> deletarTipo(int id_tipo) async {
    final response = await http.delete(Uri.parse('$baseUrl$id_tipo'));
    if (response.statusCode == 204) {
      print('Tipo deletado com sucesso');
    }
  }
}
