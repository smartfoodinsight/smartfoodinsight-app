import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smartfoodinsight_app/services/services.dart';

part 'key_storage_provider.g.dart';

@riverpod
KeyStorageService keyStorageService(KeyStorageServiceRef ref) {
  return KeyStorageService();
}
