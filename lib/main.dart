import 'package:Papyrus/features/homeLayout/presentation/cubit/HomeLayoutCubit.dart';
import 'package:Papyrus/features/homeLayout/presentation/page/HomeLayoutPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/di/Injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Papyrus',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.tajawalTextTheme(),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F172A),
          brightness: Brightness.light,
          surface: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.tajawalTextTheme(ThemeData.dark().textTheme),
        scaffoldBackgroundColor: const Color(0xFF151517),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF0F172A),
            brightness: Brightness.dark,
            surface: const Color(0xFF151517),
          ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF151517),
          foregroundColor: Colors.white,
        ),
      ),
      home: BlocProvider<HomeLayoutCubit>(
        create: (context) => HomeLayoutCubit(),
        child: const HomeLayoutPage(),
      ),
    );
  }
}
