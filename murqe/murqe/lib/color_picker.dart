import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerWidget extends StatefulWidget {
  final ValueChanged<Color> onColorSelected;
  final Color initialColor;

  const ColorPickerWidget({
    Key? key,
    required this.onColorSelected,
    this.initialColor = Colors.blue,
  }) : super(key: key);

  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  late Color _currentColor;
  final List<Color> _colorHistory = [];

  @override
  void initState() {
    super.initState();
    _currentColor = widget.initialColor;
    _colorHistory.addAll([
      Colors.deepOrangeAccent,
      Colors.greenAccent,
      Colors.lightBlueAccent,
      Colors.yellowAccent,
      Colors.purpleAccent,
      Colors.orangeAccent,
      Colors.tealAccent,
      Colors.pinkAccent,
    ]);
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('اختر لونًك المناسب'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _currentColor,
              onColorChanged: (Color color) {
                setState(() => _currentColor = color);
              },
              enableAlpha: false,
              displayThumbColor: true,
              pickerAreaHeightPercent: 0.7,
              colorPickerWidth: 300,
              pickerAreaBorderRadius: BorderRadius.circular(10),
              labelTypes: const [
                ColorLabelType.rgb,
                ColorLabelType.hsv,
                ColorLabelType.hex,
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                widget.onColorSelected(_currentColor);
                if (!_colorHistory.contains(_currentColor)) {
                  setState(() {
                    _colorHistory.add(_currentColor);
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: _showColorPicker,
          style: ElevatedButton.styleFrom(
            backgroundColor: _currentColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 2,
          ),
          child: Text(
            'اختر لونًك المناسب',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _currentColor.computeLuminance() > 0.5
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (_colorHistory.isNotEmpty) ...[
          const Text(
            'الألوان المستخدمة مسبقًا:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _colorHistory.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentColor = _colorHistory[index];
                      widget.onColorSelected(_currentColor);
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(left: 8, right: 8),
                    decoration: BoxDecoration(
                      color: _colorHistory[index],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _currentColor == _colorHistory[index]
                            ? Colors.black
                            : Colors.grey[300]!,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
