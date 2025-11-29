import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/slider.dart';
import 'package:flutter_application_1/qusition.dart';
import 'package:flutter_application_1/theme_provider.dart';
import 'package:flutter_application_1/talents_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'تطبيق الألوان',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: themeProvider.primaryColor,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
            ),
            home: const MyHomePage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List imglist = [
  'assets/images/s1.jpg',
  'assets/images/s2.jpg',
  'assets/images/s3.jpg',
];

class _MyHomePageState extends State<MyHomePage> {
  int? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,

        title: Text(
          'Slider',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Center(child: Text('one', style: TextStyle(fontSize: 32))),
          ),
          //تعريف وتفعيل السلايدر
          slider(context),
          SizedBox(height: 50),
          Center(child: Text('two', style: TextStyle(fontSize: 32))),
          slider(context),
          // CarouselSlider(
          //   items: imglist.map((item) {
          //     return Image.asset(item, fit: BoxFit.cover, width: 430);
          //   }).toList(),
          //   options: CarouselOptions(
          //     //اخلي السلايدر يمشي بشكل اوتو بدون توقف
          //     height: 200,
          //     autoPlay: true,
          //     autoPlayInterval: Duration(seconds: 1),
          //     autoPlayAnimationDuration: Duration(milliseconds: 500),
          //     autoPlayCurve: Curves.fastOutSlowIn,
          //     enableInfiniteScroll: true,
          //     viewportFraction: 1.0,
          //   ),
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Existing radio buttons
              RadioListTile<int>(
                title: Text('one'),
                value: 1,
                groupValue: _selectedValue,
                onChanged: (value) => _handleRadioValueChange(value, context),
              ),
              RadioListTile<int>(
                title: Text('two'),
                value: 2,
                groupValue: _selectedValue,
                onChanged: (value) => _handleRadioValueChange(value, context),
              ),
              RadioListTile<int>(
                title: Text('three'),
                value: 3,
                groupValue: _selectedValue,
                onChanged: (value) => _handleRadioValueChange(value, context),
              ),

              // Quiz button with some spacing
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Qusition()),
                  );
                },
                icon: const Icon(Icons.quiz),
                label: const Text(
                  'ابدأ الاختبار',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),

              // Talents page button
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TalentsPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.star),
                label: const Text(
                  'صفحة المواهب',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  backgroundColor:
                      Colors.white70, // Different color to distinguish
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleRadioValueChange(int? value, BuildContext context) {
    if (value == null) return;

    setState(() {
      _selectedValue = value;
    });

    // Show SnackBar with feedback
    final isCorrect = value == 1; // First option is correct
    final message = isCorrect ? 'إجابتك صحيحة' : 'إجابتك خاطئة';
    final color = isCorrect ? Colors.green : Colors.red;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
