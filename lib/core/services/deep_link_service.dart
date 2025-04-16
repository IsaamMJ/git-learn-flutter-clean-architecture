import 'dart:async';
import 'package:get/get.dart';
import 'package:uni_links2/uni_links.dart';

class DeepLinkService extends GetxService {
  StreamSubscription<Uri?>? _subscription;
  final Completer<void> _initCompleter = Completer<void>();

  Future<void> get onInitialized => _initCompleter.future;

  final RxnString pendingPath = RxnString();

  @override
  void onInit() {
    super.onInit();
    _initDeepLinkHandling();
  }

  void _initDeepLinkHandling() async {
    try {
      final initialUri = await getInitialUri();
      if (initialUri != null) {
        print(' Cold start URI: ${initialUri.toString()}');
        _storeDeepLink(initialUri);
      } else {
        print(' No initial URI found.');
      }

      _subscription = uriLinkStream.listen(
            (uri) {
          if (uri != null) {
            print(' Runtime URI: ${uri.toString()}');
            _storeDeepLink(uri);
          }
        },
        onError: (err) {
          print('URI stream error: $err');
        },
      );
    } catch (e) {
      print(' Error during init: $e');
    } finally {
      if (!_initCompleter.isCompleted) {
        _initCompleter.complete();
      }
    }
  }

  void _storeDeepLink(Uri uri) {
    final path = uri.path;
    pendingPath.value = path;
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
