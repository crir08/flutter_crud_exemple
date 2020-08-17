import 'package:crud/services/usager.service.dart';
import 'package:flutter/material.dart';
import 'package:crud/modeles/usager.dart';

class AjoutUsager extends StatefulWidget {
  @override
  _AjoutUsagerState createState() => _AjoutUsagerState();
}

class _AjoutUsagerState extends State<AjoutUsager> {
  final _formKey = GlobalKey<FormState>();
  final nomUsagerController = TextEditingController();
  final motDePasseController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nomUsagerController.dispose();
    motDePasseController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un usager'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                autofocus: true,
                controller: nomUsagerController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Veuillez entrer un nom d\'usager';
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  icon: const Icon(Icons.person),
                  labelText: 'Nom *',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: motDePasseController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Veuillez entrer un nom mot de passe';
                  }
                },
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  icon: const Icon(Icons.lock_outline),
                  labelText: 'Mot de passe *',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: RaisedButton(
                  onPressed: () {
                    // Si le formulaire est valide.
                    if (_formKey.currentState.validate()) {
                      print(nomUsagerController.text);
                      UsagerService.instance.insererUsager(Usager(
                          nomusager: nomUsagerController.text,
                          motdepasse: motDePasseController.text,
                        )
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Ajouter'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
