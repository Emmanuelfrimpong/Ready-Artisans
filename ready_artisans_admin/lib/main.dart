import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ready_artisans_admin/Database/hive_api.dart';
import 'package:url_strategy/url_strategy.dart';

import 'Configs/routers.gr.dart';
import 'State_Management/state_management.dart';
import 'app_colors.dart';
import 'firebase_options.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HiveApi.init();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => StateManagement(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Ready Artisans',
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
        indicatorColor: Colors.black87,
        iconTheme: const IconThemeData(color: Colors.black87),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 5,
          margin: const EdgeInsets.all(5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black87),
        canvasColor: secondaryColor,
      ),
      builder: FlutterSmartDialog.init(),
    );
  }
}

// flutter build web --web-renderer html --release

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

// flutter build web --web-renderer html --release
//flutter packages pub run build_runner build --delete-conflicting-outputs