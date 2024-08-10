import 'package:story_weaver/system/service/local_storage.dart';
import 'package:uuid/uuid.dart';

class UuidService {
  // Get or generate and store UUID in local storage
  Future<String> getOrGenerateUuid() async {
    String? storedUuid = AppLocalStorage.instance.uuid;
    if (storedUuid == null) {
      const uuid = Uuid();
      final newId = uuid.v4();
      await AppLocalStorage.instance.saveUuid(newId);
      storedUuid = newId;
    }
    return storedUuid;
  }

  // Clear UUID from local storage
  Future<void> clearUuid() async {
    await AppLocalStorage.instance.deleteUuid();
  }
}
