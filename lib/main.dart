import 'package:expense_tracker/app/core/base/notification_service_manager.dart';

import 'app/export.dart';


CustomLoader customLoader = CustomLoader();
RxBool isDarkModeTheme=false.obs;





Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  NotificationPlugin().init();
  systemThemeMode();
  orientation();
  initApp();
}



systemThemeMode() {
  var window = WidgetsBinding.instance.window;
  var brightness = window.platformBrightness;
  isDarkModeTheme.value = brightness == Brightness.dark;
  window.onPlatformBrightnessChanged = () {
    WidgetsBinding.instance.handlePlatformBrightnessChanged();
    var brightness = window.platformBrightness;
    isDarkModeTheme.value = brightness == Brightness.dark;
  };

}


init() async {
  // await GetStorage.init();
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

initApp() async {
    runApp(const MyApp());
}

orientation() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,

  );
  SystemChrome.setSystemUIOverlayStyle(  SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor:  Platform.isAndroid?AppColors.appColor:Colors.transparent,
      systemNavigationBarContrastEnforced: true,
      systemNavigationBarDividerColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

}
