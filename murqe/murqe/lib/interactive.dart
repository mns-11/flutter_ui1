import 'dart:async';
import 'package:flutter/material.dart';

class Interactive extends StatefulWidget {
  const Interactive({super.key});

  @override
  State<Interactive> createState() => _InteractiveState();
}

class _InteractiveState extends State<Interactive> {
  final ScrollController _horizontalController = ScrollController();
  Timer? _scrollTimer;
  bool _isScrollingRight = true;

  @override
  void initState() {
    super.initState();
    // Start auto-scrolling after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_horizontalController.hasClients) {
        final maxScroll = _horizontalController.position.maxScrollExtent;
        final currentScroll = _horizontalController.offset;

        if (_isScrollingRight) {
          if (currentScroll >= maxScroll - 5) {
            _isScrollingRight = false;
          } else {
            _horizontalController.animateTo(
              currentScroll + 1,
              duration: const Duration(milliseconds: 50),
              curve: Curves.linear,
            );
          }
        } else {
          if (currentScroll <= 5) {
            _isScrollingRight = true;
          } else {
            _horizontalController.animateTo(
              currentScroll - 1,
              duration: const Duration(milliseconds: 50),
              curve: Curves.linear,
            );
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' الفتى الاجمل بالعالم'),
        backgroundColor: const Color.fromARGB(255, 107, 0, 0),
      ),
      body: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(20),
        minScale: 1.0,
        maxScale: 4.0,
        child: SingleChildScrollView(
          controller: _horizontalController,
          scrollDirection: Axis.horizontal,
          child: Image.asset(
            'assets/images/5b42767f-2189-4ee6-ae18-831c079f8cf3 2.JPG',
            fit: BoxFit.cover,
            width:
                MediaQuery.of(context).size.width *
                1.5, // Make image wider than screen
          ),
        ),
      ),
    );
  }
}
