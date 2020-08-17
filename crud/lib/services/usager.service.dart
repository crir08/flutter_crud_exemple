import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crud/modeles/usager.dart';

// Service de communication avec la bd pour
// les requêtes concernant les usagers.
class UsagerService {
  UsagerService._();

  static const nomBd = 'usagers.db';
  static final UsagerService instance = UsagerService._();
  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      return await initDatabase();
    }
    return _database;
  }

  /// Permet de se connecter à la base de données.
  initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), nomBd),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE usagers(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nomusager TEXT, motdepasse TEXT)"
        );
      },
      version: 1,
    );
  }

  /// Insère un usager dans la base de données.
  Future<Usager> insererUsager(Usager usager) async {
    print("Dans la fonction d'insertion!");
    print(usager.toMap());
    final Database db = await database;
    await db.insert(
      Usager.NOMTABLE,
      usager.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Obtient l'ensemble des usagers de la base de données.
  Future<List<Usager>> usagers() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(Usager.NOMTABLE);

    return List.generate(maps.length, (i) {
      return Usager(
        id: maps[i]['id'],
        nomusager: maps[i]['nomusager'],
        motdepasse: maps[i]['motdepasse'],
      );
    });
  }

  // Modifie un usager
  Future<void> modifierUsager(Usager usager) async {
    final db = await database;

    await db.update(
      Usager.NOMTABLE,
      usager.toMap(),
      where: 'id = ?',
      whereArgs: [usager.id],
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  // Supprime un usager
  Future<void> supprimerUsager(int id) async {
    final db = await database;

    await db.delete(
      Usager.NOMTABLE,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}