import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/color_display_page.dart';

CarouselSlider slider(BuildContext context) {
  return CarouselSlider(
    items: imglist.map((item) {
      return GestureDetector(
        onTap: () {
          // Navigate to ColorDisplayPage with a smooth transition
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => ColorDisplayPage(
                initialColor: Colors.blue[300]!,
                initialColorName: 'أزرق',
              ),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 300),
            ),
          );
        },
        child: Image.asset(item, fit: BoxFit.cover, width: 430),
      );
    }).toList(),
    options: CarouselOptions(
      //اخلي السلايدر يمشي بشكل اوتو بدون توقف
      height: 200,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 1),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enableInfiniteScroll: true,
      viewportFraction: 1.0,
    ),
  );
}
