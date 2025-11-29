import 'package:flutter/material.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(child: textF1()),
          SizedBox(height: 20),
          textF1(),
          SizedBox(height: 20),
          textF1(),
        ],
      ),
    );
  }

  Container textF1() {
    return Container(
      // alignment: Alignment.center,
      width: 430,
      height: 60,
      color: Colors.greenAccent,
      child: Text(
        'Hello World Now boooo mnmn jko mnb cvb nbv mvnvn kfjm fi fkf',
        style: style1(),
      ),
    );
  }

  TextStyle style1() {
    return TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );
  }
}
