import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Imagepaker extends StatefulWidget {
  const Imagepaker({super.key});

  @override
  State<Imagepaker> createState() => _ImagepakerState();
}

class _ImagepakerState extends State<Imagepaker> {
  XFile? _pickedImage;
  bool _isLoading = false;

  Future<void> _pickImageFromCamera() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          _pickedImage = image;
        });
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في الوصول إلى الكاميرا: ${e.toString()}')),
        );
      });
      print('Error picking image: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _pickedImage = image;
        });
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في الوصول إلى المعرض: ${e.toString()}')),
        );
      });
      print('Error picking image from gallery: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Image Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Column(
                children: [
                  ElevatedButton(
                    onPressed: _pickImageFromCamera,
                    child: const Text('التقط صورة من الكاميرا'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _pickImageFromGallery,
                    child: const Text('اختر صورة من المعرض'),
                  ),
                ],
              ),
            if (_pickedImage != null) ...[
              const SizedBox(height: 20),
              Image.file(
                File(_pickedImage!.path),
                height: 200,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _removeImage,
                child: const Text('إزالة الصورة'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}