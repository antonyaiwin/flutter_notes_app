import 'package:flutter/material.dart';
import 'package:notes_app/core/constants/color_constants.dart';
import 'package:notes_app/view/splash_screen/splash_screen.dart';

void main() {
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
        scaffoldBackgroundColor: ColorConstants.scaffoldBackgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: ColorConstants.scaffoldBackgroundColor,
          foregroundColor: ColorConstants.primaryWhite,
        ),
        bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: ColorConstants.bottomSheetBackgroundColor),
      ),
      home: const SplashScreen(),
    );
  }
}
