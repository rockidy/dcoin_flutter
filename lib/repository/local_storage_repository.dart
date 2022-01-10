import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';

class LocalStorageRepository {
  final log = Logger('mainLogger');

  final _storage = const FlutterSecureStorage();
  Future<String?> getStoredValue(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (error) {
      return null;
    }
  }

  Future<void> storeValue(String key, String value) async {
    try {
      await _storage.write(key: key, value: value.toString());
    } catch (error) {
      return;
    }
  }

  Future<void> deleteStoredValue(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (exception) {
      // Logger.root.onRecord.listen((record) {
      //   print('${record.level.name}: ${record.time}: ${record.message}');
      // });
      // log.warning(exception);
      print(exception);
    }
  }
}
