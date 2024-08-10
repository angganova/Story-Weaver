import 'package:flutter/widgets.dart';
import '../../../system/service/uuid_service.dart';

class HomeVm extends ChangeNotifier {
  factory HomeVm() => instance;

  /// Singleton builder
  HomeVm._();

  static final HomeVm instance = HomeVm._();

  String? userName;

  Future<void> init() async {
    userName = await UuidService().getOrGenerateUuid();
  }
}
