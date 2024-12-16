import 'dart:io';
import 'dart:async';
import 'package:bustracking/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:bustracking/src/repository/authentication_repository/authentication_repository.dart';
import 'package:bustracking/src/utils/theme/theme.dart';
import 'package:bustracking/ticket.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class PostHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> main() async {
  HttpOverrides.global = new PostHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp().then((value) => Get.put(AuthenticationRepository()));
  }
  else{
    print(Firebase.apps);
  }
  await EasyLocalization.ensureInitialized();
  //Get.put(AuthenticationRepository());
  runApp(EasyLocalization(
    supportedLocales: [Locale('en','US'),Locale('es','US')],
    path: 'assets/translations',
    fallbackLocale: Locale('en','US'),
    child:const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: TAppTheme.lighttheme,
      darkTheme: TAppTheme.darktheme,
      themeMode: ThemeMode.system,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: Duration(milliseconds: 500),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

