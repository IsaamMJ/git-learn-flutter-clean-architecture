import 'package:get/get.dart';

class PendingNavigationService extends GetxService {
  String? _pendingPath;

  void store(String path) {
    _pendingPath = path;
  }

  String? consume() {
    final temp = _pendingPath;
    _pendingPath = null;
    return temp;
  }

  String? getPendingPath() {
    final path = consume();
    return path;
  }
}
