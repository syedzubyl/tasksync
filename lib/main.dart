import 'package:flutter/material.dart';
import 'package:tasksync/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'Themedata.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Brightness brightness = _getSystemBrightness(context);
    return  MaterialApp(
      title: "Task Sync",
        debugShowCheckedModeBanner:false,
      theme: brightness == Brightness.dark ? darkTheme : lightTheme,
      home: const HomePage(),

    );
  }
  Brightness _getSystemBrightness(BuildContext context) {
    return MediaQuery.of(context).platformBrightness;
  }

}
