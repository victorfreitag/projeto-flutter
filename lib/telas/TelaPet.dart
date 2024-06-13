import 'package:flutter/material.dart';
import 'package:pet_go/model/Pet.dart';
import 'package:pet_go/service/PetService.dart';

class TelaPet extends StatefulWidget {
  @override
  _TelaPetState createState() => _TelaPetState();
}

class _TelaPetState extends State<TelaPet> {
  late Future<List<Pet>> _pet;
  final PetService _petService = PetService();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _data_nascController = TextEditingController();
  final TextEditingController _num_documentoController = TextEditingController();
  final TextEditingController _racaController = TextEditingController();
  final TextEditingController _corController = TextEditingController();

  Pet? _petAtual;

  @override
  void initState() {
    super.initState();
    _atualizarPet();
  }

  void _atualizarPet() {
    setState(() {
      _pet= _petService.buscarPet();
    });
  }

  void _mostrarFormulario({Pet? pet}) {
    if (pet != null) {
      _petAtual = pet;
      _nomeController.text = pet.nome;
      _data_nascController.text = pet.data_nasc;
      _num_documentoController.text = pet.num_documento;
      _racaController.text = pet.raca;
      _corController.text = pet.cor;
    } else {
      _petAtual = null;
      _nomeController.clear();
      _data_nascController.clear();
      _num_documentoController.clear();
      _racaController.clear();
      _corController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _data_nascController,
              decoration: InputDecoration(labelText: 'Data de Nascimento'),
            ),
            TextField(
              controller: _num_documentoController,
              decoration: InputDecoration(labelText: 'Numero do Documento'),
            ),
            TextField(
              controller: _racaController,
              decoration: InputDecoration(labelText: 'Raça'),
            ),
            TextField(
              controller: _corController,
              decoration: InputDecoration(labelText: 'Cor'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_petAtual == null ? 'Criar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submeter() async {
    final nome = _nomeController.text;
    final data_nasc = _data_nascController.text;
    final num_documento = _num_documentoController.text;
    final raca = _racaController.text;
    final cor = _corController.text;

    if (_petAtual == null) {
      final novoPet = Pet(nome: nome, data_nasc: data_nasc, num_documento: num_documento,raca: raca, cor: cor);
      await _petService.criarPet(novoPet);
    } else {
      final petAtualizado = Pet(
        id_pet: _petAtual!.id_pet,
        nome: nome,
        data_nasc: data_nasc,
        num_documento: num_documento,
        raca: raca,
        cor: cor,
      );
      await _petService.atualizarPet(petAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarPet();
  }

  void _deletarPet(int id_pet) async {
    try {
      await _petService.deletarPet(id_pet);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pet deletado com sucesso!')));
      _atualizarPet();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar Pet: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PET'),
        centerTitle: true,
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _mostrarFormulario(),
          ),
        ],
      ),
      body: FutureBuilder<List<Pet>>(
        future: _pet,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final pet = snapshot.data![index];
                return ListTile(
                  title: Text(pet.nome,),
                  subtitle: Text('${pet.num_documento}'),


                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _mostrarFormulario(pet: pet),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletarPet(pet.id_pet!),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
