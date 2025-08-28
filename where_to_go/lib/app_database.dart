import "package:drift/drift.dart";
import "package:drift_flutter/drift_flutter.dart";
import "package:path_provider/path_provider.dart";

import "tables/dream_places_table.dart";

part "app_database.g.dart";

@DriftDatabase(tables: [DreamPlaces])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
        name: "app_db",
        native: const DriftNativeOptions(
          databaseDirectory: getApplicationDocumentsDirectory,
        ));
  }

  Future<List<DreamPlace>> getAllPlaces() => select(dreamPlaces).get();

  Future<List<DreamPlace>> getFavoritePlaces() =>
      (select(dreamPlaces)..where((tbl) => tbl.isFavorite.equals(true))).get();

  Future<DreamPlace?> getPlaceById(int id) =>
      (select(dreamPlaces)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  Future<int> insertPlace(DreamPlacesCompanion place) => into(dreamPlaces).insert(place);

  Future<int> updateFavorite(int id, {required bool isFavorite}) =>
      (update(dreamPlaces)..where((tbl) => tbl.id.equals(id)))
          .write(DreamPlacesCompanion(isFavorite: Value(isFavorite)));

  Future<int> deletePlace(int id) => (delete(dreamPlaces)..where((tbl) => tbl.id.equals(id))).go();
}
