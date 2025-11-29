import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//للتعامل مع الflushbar نقوم بتنزيل مكتبة another_flushbar
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter Demo'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            flushbar(context); //دالة منفصله..
          },
          child: const Text('Click me!'),
        ),
      ),
    );
  }

  void flushbar(BuildContext context) {
    Flushbar(
      padding: EdgeInsets.all(5),
      // animationDuration: Duration(

      // seconds: 5),
      duration: Duration(seconds: 5),
      positionOffset: 5,
      flushbarPosition: FlushbarPosition.BOTTOM,
      mainButton: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("ok"),
      ),
      icon: Icon(Icons.info, color: Colors.white),
      title: "Title",
      // message: "okey click me",
      messageText: Text("data", style: TextStyle(color: Colors.pink)),
      // duration: const Duration(seconds: 3),
    ).show(context);
  }
}
