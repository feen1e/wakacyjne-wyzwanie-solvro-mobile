import "package:flutter_riverpod/flutter_riverpod.dart";

import "app_database.dart";
import "dream_places_repository.dart";

final databaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

final placesRepositoryProvider = Provider<DreamPlacesRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return DreamPlacesRepository(db);
});

final favoritePlacesProvider = StreamProvider<List<DreamPlace>>((ref) {
  final repo = ref.watch(placesRepositoryProvider);
  return repo.watchFavoritePlaces();
});

final placeDetailsProvider = FutureProvider.family<DreamPlace, int>((ref, id) async {
  final repo = ref.watch(placesRepositoryProvider);
  final place = await repo.getPlaceById(id);
  if (place == null) {
    throw Exception("Place not found");
  }
  return place;
});

final allPlacesProvider = StreamProvider<List<DreamPlace>>((ref) {
  final repo = ref.watch(placesRepositoryProvider);
  return repo.watchAllPlaces();
});
