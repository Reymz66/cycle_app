import 'package:hive_flutter/hive_flutter.dart';

class LocaleRepository {
  LocaleRepository(this._box);

  static const boxName = 'app_settings';
  static const _key = 'locale';
  static const defaultLocaleCode = 'fr';

  final Box<String> _box;

  static Future<LocaleRepository> open() async {
    final box = await Hive.openBox<String>(boxName);
    return LocaleRepository(box);
  }

  String get() => _box.get(_key, defaultValue: defaultLocaleCode)!;

  Future<void> save(String localeCode) => _box.put(_key, localeCode);
}
