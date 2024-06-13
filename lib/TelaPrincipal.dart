import 'package:flutter/material.dart';
import 'package:pet_go/telas/TelaConsulta.dart';
import 'package:pet_go/telas/TelaPet.dart';
import 'package:pet_go/telas/TelaTipo.dart';
import 'package:pet_go/telas/TelaEspecialidade.dart';
import 'package:pet_go/telas/TelaProprietario.dart';
import 'package:pet_go/telas/TelaVeterinario.dart';

class TelaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Go'),
        centerTitle: true,
        iconTheme: const IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Menu Principal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),


            ListTile(
              leading: Icon(Icons.playlist_add_rounded),
              title: Text('Consulta'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaConsulta()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.playlist_add_rounded),
              title: Text('Especialidade'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaEspecialidade()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.playlist_add_rounded),
              title: Text('Pet'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaPet()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.playlist_add_rounded),
              title: Text('Proprietario'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaProprietario()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.playlist_add_rounded),
              title: Text('Tipo'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaTipo()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.playlist_add_rounded),
              title: Text('Veterinario'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TelaVeterinario()),
                );
              },
            )
          ],
        ),
      ),
      body: Center(
        child: Text('Bem-vindo à PetGo!',
            style: TextStyle(color: Colors.blueGrey,fontSize: 25,)
        ),
      ),
    );
  }
}