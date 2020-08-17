import 'package:crud/pages/ajout_usager.dart';
import 'package:crud/pages/modification_usager.dart';
import 'package:crud/services/usager.service.dart';
import 'package:flutter/material.dart';
import 'package:crud/modeles/usager.dart';

class ListeUsagers extends StatefulWidget {
  @override
  _ListeUsagersState createState() => _ListeUsagersState();
}

class _ListeUsagersState extends State<ListeUsagers> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des usagers'),
      ),
      body: _buildListeUsagers(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AjoutUsager()),
          ).then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildListeUsagers() {
    return FutureBuilder<List<Usager>>(
      future: UsagerService.instance.usagers(),
      builder: (context, usagers) {
        if (usagers.hasData) {
          return ListView.builder(
              itemCount: usagers.data.length,
              itemBuilder: (BuildContext _context, int i) {
                return ListTile(
                  title: Text(usagers.data[i].nomusager),
                  leading: Text(usagers.data[i].id.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        alignment: Alignment.center,
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ModificationUsager(usager: usagers.data[i],)),
                          ).then((value) {
                            setState(() {});
                          });
                        },
                      ),
                      IconButton(
                        alignment: Alignment.center,
                        icon: Icon(Icons.delete),
                        onPressed: () async {
//                          _supprimerUsager(usagers.data[i]);
//                          setState(() {});
                          _showMyDialog(usagers.data[i]);
                        },
                      ),
                    ],
                  ),
                );
              }
          );
        } else if (usagers.hasError) {
          return Text('Oops!');
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<void> _showMyDialog(Usager usager) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Suppression'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Voulez-vous vraiment supprimer ' + usager.nomusager + '?'),
              ],
            ),
          ),
          actions: [
            FlatButton(
              child: Text('Non'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Oui'),
              onPressed: () {
                Navigator.of(context).pop();
                _supprimerUsager(usager);
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }

}

void _supprimerUsager(Usager usager) {
  UsagerService.instance.supprimerUsager(usager.id);
}

