import 'dart:async';
import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:drift/web.dart';
import 'package:drift_new/data/local_database/repository/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'entities/user_entity.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    User
  ],
  daos: [
    UserDao
  ]
)
class AppDatabase extends _$AppDatabase {
  static late AppDatabase? _instance = null;

  static AppDatabase getInstance() {
    // If _instance is null (meaning it hasn't been created yet), create it.
    _instance ??= AppDatabase._();
    return _instance!;
  }

  AppDatabase._() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      ///This method is executed only the first time when database is created
      onCreate: (Migrator m) async {
        await m.createAll();
      },

      ///This method is executed every time we increase the schemaVersion number
      ///In this method is where we are handling our migration
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          //await m.addColumn(artist, artist.isActive);
          ///The code line below is when you need to migrate newly added table
          //await m.create(newTable);
        }
      },

      ///This method is helpful as it help us during development phase to check if we did migration correctly
      beforeOpen: (details) async {
        if (kDebugMode) {
          // await validateDatabaseSchema();
        }
      },
    );
  }
}

DatabaseConnection _openConnection() {
  // return WebDatabase('db');
  return DatabaseConnection.delayed(Future(() async {
    final result = await WasmDatabase.open(
      databaseName: 'my_app_db', // prefer to only use valid identifiers here
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
    );

    if (result.missingFeatures.isNotEmpty) {
      // Depending how central local persistence is to your app, you may want
      // to show a warning to the user if only unrealiable implemetentations
      // are available.
      print('Using ${result.chosenImplementation} due to missing browser '
          'features: ${result.missingFeatures}');
    }

    return result.resolvedExecutor;
  }));
}