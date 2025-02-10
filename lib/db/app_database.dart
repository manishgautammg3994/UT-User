// IN NEW:[Start]

//ignore_for_file: depend_on_referenced_packages

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'cached_places_table.dart';
part 'app_database.g.dart';

@DriftDatabase(tables: [CachedPlaces])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<CachedPlace>> getCachedPlaces() => select(cachedPlaces).get();
  Future<void> insertCachedPlace(CachedPlace place) =>
      into(cachedPlaces).insert(place);
  Future<void> clearCachedPlaces() => delete(cachedPlaces).go();
  Future<void> deleteCachedPlaces(String eventOrderId) {
    return (delete(cachedPlaces)..where((t) => t.orderId.equals(eventOrderId)))
        .go();
  }

  // static QueryExecutor _openConnection() {
  //   return driftDatabase(
  //     name: 'my_database',
  //     native: const DriftNativeOptions(),
  //   );
  // }
}
LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
// LazyDatabase _openConnection() {
//   return LazyDatabase(() async {
//     final dbFolder = await getApplicationDocumentsDirectory();
//     final file = File(p.join(dbFolder.path, 'db.sqlite'));
//     return NativeDatabase(file);
//   });
// }
// IN NEW:[End]
