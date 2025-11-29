import 'package:flutter/material.dart';

class TalentsPage extends StatefulWidget {
  const TalentsPage({super.key});

  @override
  State<TalentsPage> createState() => _TalentsPageState();
}

class _TalentsPageState extends State<TalentsPage> {
  final Map<int, bool> _selectedTalents = {};
  final List<Map<String, dynamic>> _talents = [
    {'id': 1, 'name': 'الرسم', 'color': Colors.purple},
    {'id': 2, 'name': 'الخطابة', 'color': Colors.blue},
    {'id': 3, 'name': 'الكتابة', 'color': Colors.green},
    {'id': 4, 'name': 'البرمجة', 'color': Colors.orange},
    {'id': 5, 'name': 'التصميم', 'color': Colors.pink},
    {'id': 6, 'name': 'الطبخ', 'color': Colors.red},
    {'id': 7, 'name': 'التصوير', 'color': Colors.teal},
    {'id': 8, 'name': 'الرياضة', 'color': Colors.amber},
  ];

  @override
  void initState() {
    super.initState();
    // Initialize all talents as not selected
    for (var talent in _talents) {
      _selectedTalents[talent['id']] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'اختر مواهبك',
          style: TextStyle(fontFamily: 'Arial'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'ما هي مواهبك؟',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Arial',
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 20),
              ..._buildTalentTiles(),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitSelection,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'تأكيد الاختيارات',
                  style: TextStyle(fontSize: 18, fontFamily: 'Arial'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTalentTiles() {
    return _talents.map((talent) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        child: CheckboxListTile(
          title: Text(
            talent['name'],
            style: TextStyle(
              fontFamily: 'Arial',
              color: _selectedTalents[talent['id']]! 
                  ? talent['color'] 
                  : Colors.black87,
              fontWeight: _selectedTalents[talent['id']]! 
                  ? FontWeight.bold 
                  : FontWeight.normal,
            ),
            textAlign: TextAlign.right,
          ),
          value: _selectedTalents[talent['id']],
          onChanged: (bool? value) {
            setState(() {
              _selectedTalents[talent['id']] = value!;
            });
          },
          activeColor: talent['color'],
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
      );
    }).toList();
  }

  void _submitSelection() {
    final selected = _talents
        .where((talent) => _selectedTalents[talent['id']] == true)
        .map((talent) => talent['name'])
        .toList();

    if (selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء اختيار موهبة واحدة على الأقل', 
              textAlign: TextAlign.right),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('المواهب المختارة', 
            textAlign: TextAlign.right, 
            style: TextStyle(fontFamily: 'Arial')),
        content: Text(
          selected.join('\n'),
          textAlign: TextAlign.right,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً', 
                style: TextStyle(fontFamily: 'Arial')),
          ),
        ],
      ),
    );
  }
}
