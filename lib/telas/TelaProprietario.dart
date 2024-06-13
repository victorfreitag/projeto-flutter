import 'package:flutter/material.dart';
import 'package:pet_go/model/Proprietario.dart';
import 'package:pet_go/service/ProprietarioService.dart';

class TelaProprietario extends StatefulWidget {
  @override
  _TelaProprietarioState createState() => _TelaProprietarioState();
}

class _TelaProprietarioState extends State<TelaProprietario> {
  late Future<List<Proprietario>> _proprietario;
  final ProprietarioService _proprietarioService = ProprietarioService();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _telefone1Controller = TextEditingController();
  final TextEditingController _telefone2Controller = TextEditingController();

  Proprietario? _proprietarioAtual;

  @override
  void initState() {
    super.initState();
    _atualizarProprietario();
  }

  void _atualizarProprietario() {
    setState(() {
      _proprietario = _proprietarioService.buscarProprietario();
    });
  }

  void _mostrarFormulario({Proprietario? proprietario}) {
    if (proprietario != null) {
      _proprietarioAtual = proprietario;
      _nomeController.text = proprietario.nome;
      _cpfController.text = proprietario.cpf;
      _ruaController.text = proprietario.rua;
      _bairroController.text = proprietario.bairro;
      _cidadeController.text = proprietario.cidade;
      _telefone1Controller.text = proprietario.telefone1;
      _telefone2Controller.text = proprietario.telefone2;
    } else {
      _proprietarioAtual = null;
      _nomeController.clear();
      _cpfController.clear();
      _ruaController.clear();
      _bairroController.clear();
      _cidadeController.clear();
      _telefone2Controller.clear();
      _telefone2Controller.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 10,
          left: 10,
          right: 10,
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
              controller: _telefone1Controller,
              decoration: InputDecoration(labelText: 'Telefone1'),
            ),
            TextField(
              controller: _telefone2Controller,
              decoration: InputDecoration(labelText: 'Telefone2'),

            ),
            SizedBox(width: 100),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_proprietarioAtual == null ? 'Criar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submeter() async {
    final nome = _nomeController.text;
    final cpf = _cpfController.text;
    final rua = _ruaController.text;
    final bairro = _bairroController.text;
    final cidade = _cidadeController.text;
    final telefone1 = _telefone1Controller.text;
    final telefone2 = _telefone2Controller.text;

    if (_proprietarioAtual == null) {
      final novoProprietario = Proprietario(nome: nome, cpf:cpf,rua:rua,bairro:bairro,cidade: cidade,telefone1: telefone1,telefone2: telefone2);
      await _proprietarioService.criarProprietario(novoProprietario);
    } else {
      final proprietarioAtualizado = Proprietario(
        id: _proprietarioAtual!.id,
        nome: nome,
        cpf: cpf,
        rua: rua,
        bairro: bairro,
        cidade: cidade,
        telefone1: telefone1,
        telefone2: telefone2,
      );
      await _proprietarioService.atualizarProprietario(proprietarioAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarProprietario();
  }

  void _deletarProprietario(int id_proprietario) async {
    try {
      await _proprietarioService.deletarProprietario(id_proprietario);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Proprietário deletado com sucesso!')));
      _atualizarProprietario();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar Proprietário: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PROPRIETÁRIO'),
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
              icon: Icon(Icons.add_outlined, color: Colors.white,),
              onPressed: () => _mostrarFormulario(),
            ),
          ],
        ),
      body: FutureBuilder<List<Proprietario>>(
        future: _proprietario,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final proprietario = snapshot.data![index];
                return ListTile(
                  title: Text(proprietario.nome),
                  subtitle: Text('${proprietario.cpf}'),


                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blueAccent),
                        onPressed: () => _mostrarFormulario(proprietario: proprietario),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_forever_rounded, color: Colors.red),
                        onPressed: () => _deletarProprietario(proprietario.id!),
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
