import 'package:flutter/material.dart';
import 'package:flutter_application_1/color_display_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/theme_provider.dart';

class Radiolist extends StatefulWidget {
  const Radiolist({super.key});

  @override
  State<Radiolist> createState() => _RadiolistState();
}

class _RadiolistState extends State<Radiolist> {
  int? _selectedValue;
  final List<Map<String, dynamic>> _radioButtons = [
    {'value': 1, 'label': 'أزرق فاتح', 'color': Colors.blue[100]!},
    {'value': 2, 'label': 'أزرق متوسط', 'color': Colors.blue[300]!},
    {'value': 3, 'label': 'أزرق غامق', 'color': Colors.blue[500]!},
    {'value': 4, 'label': 'أخضر فاتح', 'color': Colors.green[100]!},
    {'value': 5, 'label': 'أخضر متوسط', 'color': Colors.green[400]!},
    {'value': 6, 'label': 'أخضر غامق', 'color': Colors.green[700]!},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'قائمة الاختيارات',
          style: TextStyle(fontFamily: 'Arial'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _radioButtons.map((button) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              child: RadioListTile<int>(
                title: Text(
                  button['label'],
                  style: TextStyle(
                    fontFamily: 'Arial',
                    color: _selectedValue == button['value']
                        ? button['color']
                        : Colors.black87,
                    fontWeight: _selectedValue == button['value']
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  textAlign: TextAlign.right,
                ),
                value: button['value'],
                groupValue: _selectedValue,
                activeColor: button['color'],
                onChanged: (int? value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
