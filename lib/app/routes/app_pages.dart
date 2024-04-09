
import '../export.dart';

class AppPages {
  static const INITIAL = AppRoutes.splashRoute;

  static final routes = [
    GetPage(
      name: AppRoutes.splashRoute,
      page: () => SplashScreen(),
      bindings: [SplashBinding()],
    ),


    GetPage(
      name: AppRoutes.loginRoute,
      page: () => LoginScreen(),
      bindings: [LoginBinding()],
    ),

    GetPage(
      name: AppRoutes.signupRoute,
      page: () => SignUpScreen(),
      bindings: [SignUpBinding()],
    ),

    GetPage(
      name: AppRoutes.otpVerificationRoute,
      page: () => OtpVerificationScreen(),
      bindings: [OtpVerificationBinding()],
    ),

    GetPage(
      name: AppRoutes.congratulationRoute,
      page: () => CongratulationScreen(),
      bindings: [CongratulationBinding()],
    ),

    GetPage(
      name: AppRoutes.homeRoute,
      page: () => HomeScreen(),
      bindings: [HomeBinding()],
    ),

    GetPage(
      name: AppRoutes.AddExpenseRoute,
      page: () => AddExpenseScreen(),
      bindings: [AddExpenseBinding()],
    ),


  ];
}
