import 'package:favorite_strings_flutter/data/data_sources/favoritable_strings_local_data_source.dart';
import 'package:favorite_strings_flutter/domain/entities/favoritable_string.dart';

class FavoritableStringsRepository {
  FavoritableStringsRepository(this._local);

  final FavoritableStringsLocalDataSource _local;

  Future<List<FavoritableString>> read() async => _local.read();

  Future<void> update(String title, bool fav) async {
    _local.update(title, fav);
  }
}
