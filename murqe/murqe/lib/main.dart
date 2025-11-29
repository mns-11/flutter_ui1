import 'package:flutter/material.dart';
import 'package:murqe/color_picker.dart';
import 'package:murqe/interactive.dart';
import 'package:murqe/listviewscorller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'التقويم الهجري',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF2C3E50),     // Dark blue
          secondary: const Color(0xFFE74C3C),   // Red
          surface: Colors.white,
          background: const Color(0xFFF8F9FA),  // Light gray background
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: const Color(0xFF2C3E50),   // Dark blue text
          onBackground: const Color(0xFF2C3E50), // Dark blue text
          brightness: Brightness.light,
        ),
        cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF2C3E50),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            color: Color(0xFF34495E),
          ),
        ),
        useMaterial3: true,
      ),
      home:  Interactive(),
    );
  }
}

class ColorChangePage extends StatefulWidget {
  const ColorChangePage({super.key});

  @override
  State<ColorChangePage> createState() => _ColorChangePageState();
}

class _ColorChangePageState extends State<ColorChangePage> {
  Color _backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('تغيير لون الصفحة'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 128, 16, 16),
        foregroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ColorPickerWidget(
              initialColor: _backgroundColor,
              onColorSelected: (Color color) {
                setState(() {
                  _backgroundColor = color;
                });
              },
            ),
          ),
        ),
      ),
      body: Container(),
    );
  }
}
