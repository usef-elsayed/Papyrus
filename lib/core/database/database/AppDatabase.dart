import 'package:Papyrus/core/database/tables/BooksTable.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import '../../constants/DBConstants.dart';
part 'AppDatabase.g.dart';

@DriftDatabase(tables: [BooksTable])
@lazySingleton
class AppDatabase extends _$AppDatabase {

  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => databaseSchemaVersion;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: databaseName,
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

}