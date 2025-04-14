import 'dart:async';
import 'package:get/get.dart';
import 'package:uni_links2/uni_links.dart';
import 'package:untitled/routes/app_routes.dart';
import 'package:untitled/controller/home_controller.dart';
import 'package:untitled/core/services/pending_navigation_service.dart';
import 'package:untitled/presentation/bindings/home_binding.dart';

class DeepLinkService extends GetxService {
  StreamSubscription<Uri?>? _subscription;

  @override
  void onInit() {
    super.onInit();
    _initDeepLinkHandling();
  }

  void _initDeepLinkHandling() async {
    try {
      final initialUri = await getInitialUri();
      if (initialUri != null) _handleUri(initialUri);

      _subscription = uriLinkStream.listen(
            (uri) {
          if (uri != null) _handleUri(uri);
        },
        onError: (err) => print('Deep link error: $err'),
      );
    } catch (e) {
      print('Failed to initialize deep linking: $e');
    }
  }

  void _handleUri(Uri uri) async {
    final path = uri.path;

    if (!Get.isRegistered<HomeController>()) {
      HomeBinding().dependencies();
    }

    final homeCtrl = Get.find<HomeController>();
    final pendingNav = Get.find<PendingNavigationService>();

    final isLoggedIn = await homeCtrl.readLoginStatusFromStorage();

    if (!isLoggedIn) {
      pendingNav.store(path);
      await Future.delayed(const Duration(milliseconds: 100));
      Get.offAllNamed(AppRoutes.login);
      return;
    }
    navigateToPath(path);
  }

  void navigateToPath(String path, {bool fromLogin = false}) async {
    if (path == '/home') {
      Get.offAllNamed(AppRoutes.main, arguments: 'home');
    } else if (path == '/api-data') {
      Get.offAllNamed(AppRoutes.main, arguments: 'api-data');
    } else if (path.startsWith('/car/')) {
      final id = path.split('/').last;

      final isMainRouteActive = Get.currentRoute == AppRoutes.main;

      if (fromLogin || !isMainRouteActive) {
        await Get.offAllNamed(AppRoutes.main, arguments: 'home');
        await Future.delayed(const Duration(milliseconds: 100));
      }

      Get.toNamed('/car/$id');
    } else {
      Get.offAllNamed(AppRoutes.main, arguments: 'home');
    }
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
