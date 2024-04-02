import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/core/constants/color_constants.dart';
import 'package:notes_app/view/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('notesBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ColorConstants.scaffoldBackgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: ColorConstants.scaffoldBackgroundColor,
          foregroundColor: ColorConstants.primaryWhite,
        ),
        bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: ColorConstants.bottomSheetBackgroundColor),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: ColorConstants.primaryWhite.withOpacity(0.5))),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: ColorConstants.inputFillColor,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
