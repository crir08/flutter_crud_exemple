import 'package:crud/modeles/usager.dart';
import 'package:crud/services/usager.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModificationUsager extends StatefulWidget {
  final Usager usager;

  const ModificationUsager({Key key, this.usager}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ModificationUsagerState(usager);
}

class _ModificationUsagerState extends State<ModificationUsager> {
  final Usager usager;
  final _formKey = GlobalKey<FormState>();
  final nomUsagerController = TextEditingController();
  final motDePasseController = TextEditingController();

  _ModificationUsagerState(this.usager);

  @override
  void initState() {
    super.initState();
    if (usager != null) {
      nomUsagerController.text = usager.nomusager;
      motDePasseController.text = usager.motdepasse;
    }
  }

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
        title: Text('Modifier un usager'),
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
                    _modifierUsager(nomUsagerController.text, motDePasseController.text);
                    setState(() {});
                  }
                },
                child: Text('Enregistrer'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _modifierUsager(String nomusager, String motdepasse) async {
    if (usager == null) {
      UsagerService.instance.insererUsager(Usager(
        nomusager: nomusager,
        motdepasse: motdepasse
      ));
      Navigator.pop(context);
    } else {
      await UsagerService.instance.modifierUsager(Usager(
        id: usager.id,
        nomusager: nomusager,
        motdepasse: motdepasse
      ));
      Navigator.pop(context);
    }
  }
}


