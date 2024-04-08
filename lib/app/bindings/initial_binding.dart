import '../export.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    LocalSourceBindings().dependencies();
    SplashBinding().dependencies();
  }
}
