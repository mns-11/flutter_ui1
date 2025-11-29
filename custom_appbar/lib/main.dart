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
      // appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('erorr'),
                  content: Text('This is erorr'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.infinity,
                        // height: 5,
                        color: Colors.amberAccent,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Text(
                          'OK!',
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Button'),
        ),
      ),
    );
  }
}     
        //بهذاالشكل تقدر تتحكم بخصائص ال appbar
        //تقدر تعطيه ارتفاع معين
        // child: 
        // CustomScrollView(
        //   slivers: [
        //     SliverAppBar(
        //       expandedHeight: 40,
        //       //leading يتم اضافة الicon بالجهه اليسار
        //       leading: Padding(
        //         padding: EdgeInsets.all(10),
        //         child: Row(
        //           children: [
        //             Expanded(
        //               child: IconButton(
        //                 onPressed: () {},
        //                 icon: Icon(Icons.person),
        //               ),
        //             ),
        //             SizedBox(width: 30),
        //             Expanded(
        //               child: IconButton(
        //                 onPressed: () {},
        //                 icon: Icon(Icons.add),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
              //actions يتم اضافة الicon بالجهه اليمين
              // actions: [
              //   Padding(
              //     padding: EdgeInsets.all(20),
              //     child: Icon(Icons.call_end),
              //   ),
              // ],
              // //flexibleSpace هوعبارة عن widget تتيح اضافة العديد
              //من الwidgets مثلا container وتستفيد من خصائصه
              // flexibleSpace: Container(
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       colors: [
              //         const Color.fromARGB(255, 237, 146, 140),
              //         const Color.fromARGB(255, 232, 134, 167),
              //         const Color.fromARGB(255, 166, 108, 176),
              //         const Color.fromARGB(255, 134, 192, 240),
              //       ],
              //     ),
              //   ),
              // ),
              // centerTitle: true, //يخلي النص في المنتصف
              // backgroundColor: Colors.blueAccent,
              // title: Text(
                // 'flutter demo',
                // style: TextStyle(
                //   fontSize: 30,
                //   fontWeight: FontWeight.bold,
                //   color: Colors.black,
                // ),
              // ),
              // backgroundColor: Colors.amber,
            // ),
          // ],
        // ),
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.business),
      //       label: 'Business',
      //     ),
      //     BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
      //   ],
      // ),
    // );
  // }
// }
