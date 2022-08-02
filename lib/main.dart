import 'package:bike_service_app/Binding/controller_binding.dart';
import 'package:bike_service_app/controller/auth_controller.dart';
import 'package:bike_service_app/view/provider_dashboard.dart';
import 'package:bike_service_app/view/user_dashboard.dart';
import 'package:bike_service_app/view/account_edit.dart';
import 'package:bike_service_app/view/otp.dart';
import 'package:bike_service_app/view/signin.dart';
import 'package:bike_service_app/view/signin_details.dart';
import 'package:bike_service_app/view/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      initialBinding: ControllerBinding(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      getPages: [
        GetPage(name: '/SPLASH', page: () => SplashScreen()),
        GetPage(name: '/SIGNUP', page: () => SignIn()),
        GetPage(name: '/OTP', page: () => OTP()),
        GetPage(name: '/REGISTRATION', page: () => Registration()),
        GetPage(name: '/USERDASHBOARD', page: () => UserDashboard()),
        GetPage(name: '/PROVIDERDASHBOARD', page: () => ProviderDashboard()),
        GetPage(name: '/ACCOUNTEDIT', page: () => AccountEdit()),
      ],
      initialRoute: 'SPLASH',
    );
  }
}
