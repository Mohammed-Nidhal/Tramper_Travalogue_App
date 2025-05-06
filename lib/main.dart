import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tramber/View/modules/user/intro_pages/splash_screen.dart';

import 'package:tramber/ViewModel/check_login_preference.dart';
import 'package:tramber/ViewModel/controll_provider.dart';
import 'package:tramber/ViewModel/firestore.dart';
import 'package:tramber/ViewModel/get_locatiion.dart';
import 'package:tramber/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getLoggedPrefer();

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Firestore>(create: (_) => Firestore()),
        ChangeNotifierProvider<LocationPrvider>(
            create: (_) => LocationPrvider()),
        ChangeNotifierProvider<Controller>(create: (_) => Controller())
      ],
      child: MaterialApp(
        // title: 'Flutter Demo',
        theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
            //  home: const PlaceMainPage(),
        home: const splash_screen(),
        // home: HomePageAdmin(),
        // home: PlaceListPage(),
        // home: profile(),
        // debugShowCheckedModeBanner: false,
      ),
    );
  }
}
