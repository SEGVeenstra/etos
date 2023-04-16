import '../entities/favoritable_string.dart';

extension FavoritableStringListExt on List<FavoritableString> {
  List<FavoritableString> replaceString(FavoritableString newString) {
    final index = indexWhere((element) => element.string == newString.string);
    return [...this]
      ..removeAt(index)
      ..insert(index, newString);
  }

  List<FavoritableString> removeString(String string) {
    return [...this]..removeWhere((element) => element.string == string);
  }
}
