import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_go/model/Veterinario.dart';

class VeterinarioService {
  static const String baseUrl = 'http://192.168.56.1:8080/veterinario/';

  Future<List<Veterinario>> buscarVeterinario() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic veterinario) => Veterinario.fromJson(veterinario)).toList();
    } else {
      throw Exception('Falha ao carregar veterinario');
    }
  }

  Future<void> criarVeterinario(Veterinario veterinario) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(veterinario.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Falha ao criar Veterinario');
    }
  }

  Future<void> atualizarVeterinario(Veterinario veterinario) async {
    final response = await http.put(
      Uri.parse('$baseUrl${veterinario.id}'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(veterinario.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar Veterinario');
    }
  }

  Future<void> deletarVeterinario(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl$id'));
    if (response.statusCode == 204) {
      print('Veterinario deletado com sucesso');
    } else {
      print('Erro ao deletar Veterinario: ${response.statusCode} ${response.body}');
      throw Exception('Falha ao deletar Veterinario');
    }
  }
}
