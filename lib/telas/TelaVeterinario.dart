import 'package:flutter/material.dart';
import 'package:pet_go/model/Veterinario.dart';
import 'package:pet_go/service/VeterinarioService.dart';

class TelaVeterinario extends StatefulWidget {
  @override
  _TelaVeterinarioState createState() => _TelaVeterinarioState();
}

class _TelaVeterinarioState extends State<TelaVeterinario> {
  late Future<List<Veterinario>> _veterinarios;
  final VeterinarioService _veterinarioService = VeterinarioService();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();
  final TextEditingController _telefone1Controller = TextEditingController();
  final TextEditingController _telefone2Controller = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _crmvController = TextEditingController();

  Veterinario? _veterinarioAtual;

  @override
  void initState() {
    super.initState();
    _atualizarVeterinarios();
  }

  void _atualizarVeterinarios() {
    setState(() {
      _veterinarios = _veterinarioService.buscarVeterinario();
    });
  }

  void _mostrarFormulario({Veterinario? veterinario}) {
    if (veterinario != null) {
      _veterinarioAtual = veterinario;
      _nomeController.text = veterinario.nome;
      _cpfController.text = veterinario.cpf;
      _rgController.text = veterinario.rg;
      _telefone1Controller.text = veterinario.telefone1;
      _telefone2Controller.text = veterinario.telefone2;
      _ruaController.text = veterinario.rua;
      _bairroController.text = veterinario.bairro;
      _cidadeController.text = veterinario.cidade;
      _crmvController.text = veterinario.crmv;
    } else {
      _veterinarioAtual = null;
      _nomeController.clear();
      _cpfController.clear();
      _rgController.clear();
      _telefone1Controller.clear();
      _telefone2Controller.clear();
      _ruaController.clear();
      _bairroController.clear();
      _cidadeController.clear();
      _crmvController.clear();
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
              controller: _cpfController,
              decoration: InputDecoration(labelText: 'Cpf'),
            ),
            TextField(
              controller: _rgController,
              decoration: InputDecoration(labelText: 'Rg'),
            ),
            TextField(
              controller: _telefone1Controller,
              decoration: InputDecoration(labelText: 'Telefone1'),
            ),
            TextField(
              controller: _telefone2Controller,
              decoration: InputDecoration(labelText: 'telefone2'),
            ),
            TextField(
              controller: _ruaController,
              decoration: InputDecoration(labelText: 'Rua'),
            ),
            TextField(
              controller: _bairroController,
              decoration: InputDecoration(labelText: 'Bairro'),
            ),
            TextField(
              controller: _cidadeController,
              decoration: InputDecoration(labelText: 'Cidade'),
            ),
            TextField(
              controller: _crmvController,
              decoration: InputDecoration(labelText: 'Crmv'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_veterinarioAtual == null ? 'Criar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submeter() async {
    final nome = _nomeController.text;
    final cpf = _cpfController.text;
    final rg = _rgController.text;
    final telefone1 = _telefone1Controller.text;
    final telefone2 = _telefone2Controller.text;
    final rua = _ruaController.text;
    final bairro = _bairroController.text;
    final cidade = _cidadeController.text;
    final crmv = _crmvController.text;

    if (_veterinarioAtual == null) {
      final novoVeterinario = Veterinario(nome: nome,cpf: cpf,rg: rg,telefone1: telefone1,telefone2: telefone2,rua: rua,bairro: bairro,cidade:cidade,crmv: crmv);
      await _veterinarioService.criarVeterinario(novoVeterinario);
    } else {
      final veterinarioAtualizado = Veterinario(
        id: _veterinarioAtual!.id,
        nome: nome,
        cpf: cpf,
        rg: rg,
        telefone1: telefone1,
        telefone2: telefone2,
        rua: rua,
        bairro: bairro,
        cidade: cidade,
        crmv: crmv,
      );
      await _veterinarioService.atualizarVeterinario(veterinarioAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarVeterinarios();
  }

  void _deletarVeterinario(int id) async {
    try {
      await _veterinarioService.deletarVeterinario(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veterinário deletado com sucesso!')));
      _atualizarVeterinarios();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar Veterinário: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VETERINÁRIO'),
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
      body: FutureBuilder<List<Veterinario>>(
        future: _veterinarios,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final veterinario = snapshot.data![index];
                return ListTile(
                  title: Text(veterinario.nome),
                  subtitle: Text('${veterinario.cpf}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _mostrarFormulario(veterinario: veterinario),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletarVeterinario(veterinario.id!),
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
