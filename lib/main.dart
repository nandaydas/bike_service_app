import 'package:bike_service_app/Binding/controller_binding.dart';
import 'package:bike_service_app/controller/auth_controller.dart';
import 'package:bike_service_app/view/Provider_Side/provider_dashboard.dart';
import 'package:bike_service_app/view/User_side/user_dashboard.dart';
import 'package:bike_service_app/view/otp.dart';
import 'package:bike_service_app/view/signin.dart';
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
        GetPage(name: '/SIGNUP', page: () => SignIn()),
        GetPage(name: '/OTP', page: () => OTP()),
        GetPage(name: '/USERDASHBOARD', page: () => UserDashboard()),
        GetPage(name: '/PROVIDERDASHBOARD', page: () => ProviderDashboard()),
      ],
      initialRoute: 'SIGNUP',
    );
  }
}
