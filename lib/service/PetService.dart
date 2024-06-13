import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_go/model/Pet.dart';

class PetService {
  static const String baseUrl = 'http://192.168.56.1:8080/pet/';

  Future<List<Pet>> buscarPet() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic pet) => Pet.fromJson(pet)).toList();
    } else {
      throw Exception('Falha ao carregar especialidades');
    }
  }

  Future<void> criarPet(Pet pet) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(pet.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Falha ao criar pet');
    }
  }

  Future<void> atualizarPet(Pet pet) async {
    final response = await http.put(
      Uri.parse('$baseUrl${pet.id_pet}'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(pet.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar pet');
    }
  }

  Future<void> deletarPet(int id_pet) async {
    final response = await http.delete(Uri.parse('$baseUrl$id_pet'));
    if (response.statusCode == 204) {
      print('Pet deletado com sucesso');
    } else {
      print('Erro ao deletar pet: ${response.statusCode} ${response.body}');
      throw Exception('Falha ao deletar pet');
    }
  }
}
