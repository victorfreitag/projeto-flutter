import 'package:flutter/material.dart';
import 'package:pet_go/model/Consulta.dart';
import 'package:pet_go/service/ConsultaService.dart';


class TelaConsulta extends StatefulWidget {
  @override
  _TelaConsultaState createState() => _TelaConsultaState();
}

class _TelaConsultaState extends State<TelaConsulta> {
  late Future<List<Consulta>> _consulta;
  final ConsultaService _consultaService = ConsultaService();

  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _horarioController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();


  Consulta? _consultaAtual;

  @override
  void initState() {
    super.initState();
    _atualizarConsulta();
  }

  void _atualizarConsulta() {
    setState(() {
      _consulta = _consultaService.buscarConsultas();
    });
  }

  void _mostrarFormulario({Consulta? consulta}) {
    if (consulta != null) {
      _consultaAtual = consulta;
      _dataController.text = consulta.data;
      _horarioController.text = consulta.horario;
      _descricaoController.text = consulta.descricao;

    } else {
      _consultaAtual = null;
      _dataController.clear();
      _horarioController.clear();
      _descricaoController.clear();
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
              controller: _dataController,
              decoration: InputDecoration(labelText: 'Data'),
            ),
            TextField(
              controller: _horarioController,
              decoration: InputDecoration(labelText: 'Horario'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submeter,
              child: Text(_consultaAtual == null ? 'Criar' : 'Atualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _submeter() async {
    final data = _dataController.text;
    final horario = _horarioController.text;
    final descricao = _descricaoController.text;

    if (_consultaAtual == null) {
      final novoConsulta = Consulta(data: data, horario: horario, descricao: descricao);
      await _consultaService.criarConsulta(novoConsulta);
    }
    else {
      final consultaAtualizado = Consulta(
        id_consulta: _consultaAtual!.id_consulta,
        data: data,
        horario: horario,
        descricao: descricao,
      );
      await _consultaService.atualizarConsulta(consultaAtualizado);
    }

    Navigator.of(context).pop();
    _atualizarConsulta();
  }

  void _deletarProduto(int id_consulta) async {
    try {
      await _consultaService.deletarConsulta(id_consulta);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Produto deletado com sucesso!')));
      _atualizarConsulta();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Falha ao deletar consulta: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CONSULTA'),
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
      body: FutureBuilder<List<Consulta>>(
        future: _consulta,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final consulta = snapshot.data![index];
                return ListTile(
                  title: Text(consulta.data),
                  subtitle: Text('${consulta.descricao}'),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _mostrarFormulario(consulta: consulta),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletarProduto(consulta.id_consulta!),
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
