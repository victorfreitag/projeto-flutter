import 'package:flutter/material.dart';
import 'package:pet_go/model/Tipo.dart';
import 'package:pet_go/service/TipoService.dart';


class TelaTipo extends StatefulWidget {
  @override
  _TelaEspecialidadeState createState() => _TelaEspecialidadeState();
}

class _TelaEspecialidadeState extends State<TelaTipo> {
  late Future<List<Tipo>> _tipo;
  final TipoService _tipoService = TipoService();

  final TextEditingController _nomeController = TextEditingController();

  Tipo? _tipoAtual;

  @override
  void initState() {
    super.initState();
    _atualizarEspecialidade();
  }

  void _atualizarEspecialidade() {
    setState(() {
      _tipo = _tipoService.buscarTipo();
    });
  }

  void _mostrarFormulario({Tipo? tipo}) {
    if (tipo != null) {
      _tipoAtual = tipo;
      _nomeController.text = tipo.nome;


    } else {
      _tipoAtual = null;
      _nomeController.clear();
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

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_tipoAtual == null ? 'Criar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submeter() async {
    final nome = _nomeController.text;


    if (_tipoAtual == null) {
      final novoEspecialidade = Tipo(nome: nome);
      await _tipoService.criarTipo(novoEspecialidade);
    }
    else {
      final tipoAtualizado = Tipo(
        id_tipo: _tipoAtual!.id_tipo,
        nome: nome,
      );
      await _tipoService.atualizarTipo(tipoAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarEspecialidade();
  }

  void _deletarEspecialidade(int id_tipo) async {
    try {
      await _tipoService.deletarTipo(id_tipo);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tipo deletado com sucesso!')));
      _atualizarEspecialidade();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar Tipo: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TIPO'),
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
      body: FutureBuilder<List<Tipo>>(
        future: _tipo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final tipo = snapshot.data![index];
                return ListTile(
                  title: Text(tipo.nome),
                  subtitle: Text('${tipo.nome}'),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _mostrarFormulario(tipo: tipo),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletarEspecialidade(tipo.id_tipo!),
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
