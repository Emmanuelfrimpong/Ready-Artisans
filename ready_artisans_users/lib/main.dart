import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ready_artisans/Database/local_database.dart';
import 'package:ready_artisans/Pages/Home/home_page.dart';
import 'package:ready_artisans/Styles/app_colors.dart';
import 'Database/firebase_api.dart';
import 'Models/Users/users.dart';
import 'Pages/Welcome/welcome_page.dart';
import 'Providers/navigation_provider.dart';
import 'Providers/location_provider.dart';
import 'Providers/user_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HiveApi().init();
  //await FirebaseApi.signOut();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => NavigationProvider()),
    ChangeNotifierProvider(create: (_) => LocationService()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LocationService>(context, listen: false).getCurrentPosition();
    });
  }

  getUser() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Provider.of<LocationService>(context, listen: false)
              .getCurrentPosition();
        });
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          User? user = snapshot.data;
          return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseApi.getUserStream(user!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.exists) {
                  Users users = Users.fromJson(
                      snapshot.data!.data() as Map<String, dynamic>);
                  // HiveApi().setUser(users);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Provider.of<UserProvider>(context, listen: false)
                        .setUser(users);
                  });
                }
                return const HomePage();
              });
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        } else {
          return const WelcomePage();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ready Artisans',
      debugShowCheckedModeBanner: false,
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
        canvasColor: primaryColor,
      ),
      builder: FlutterSmartDialog.init(),
      home: FutureBuilder<bool>(
          future: null,
          builder: (context, snapshot) {
            return getUser();
          }),
    );
  }
}
