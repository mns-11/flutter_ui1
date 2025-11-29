import 'package:flutter/material.dart';
import 'radiolist.dart';

class ColorDisplayPage extends StatefulWidget {
  final Color initialColor;
  final String initialColorName;

  const ColorDisplayPage({
    super.key,
    required this.initialColor,
    required this.initialColorName,
  });

  @override
  _ColorDisplayPageState createState() => _ColorDisplayPageState();
}

class _ColorDisplayPageState extends State<ColorDisplayPage> {
  // List of color options with names and colors
  final List<Map<String, dynamic>> colorOptions = [
    {'name': 'أحمر', 'color': Colors.red},
    {'name': 'أخضر', 'color': Colors.green},
    {'name': 'أزرق', 'color': Colors.blue},
    {'name': 'أصفر', 'color': Colors.yellow},
  ];

  late Color selectedColor;
  late String colorName;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.initialColor;
    colorName = widget.initialColorName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: selectedColor,
      appBar: AppBar(
        title: const Text(
          'اختر اللون الصحيح',
          style: TextStyle(fontFamily: 'Arial'),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [selectedColor.withOpacity(0.8), selectedColor],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'ما هو لون الخلفية الحالي؟',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial',
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // Grid of color options
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: colorOptions.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Update the selected color
                        setState(() {
                          selectedColor = colorOptions[index]['color'];
                          colorName = colorOptions[index]['name'];
                        });

                        // Show feedback
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'تم اختيار: ${colorOptions[index]['name']}',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorOptions[index]['color'].withOpacity(0.7),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colorOptions[index]['color'],
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.color_lens,
                                    size: 50,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Text(
                                colorOptions[index]['name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'رجوع',
                        style: TextStyle(fontFamily: 'Arial'),
                      ),
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.pushAndRemoveUntil(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => const Radiolist(),
                    //       ),
                    //       (route) => false,
                    // );
                    // },
                    // child: const Text(
                    // 'العودة للقائمة',
                    // style: TextStyle(fontFamily: 'Arial'),
                    // ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
