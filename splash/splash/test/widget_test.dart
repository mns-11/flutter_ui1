import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:splash/main.dart';

void main() {
  testWidgets('App starts with onboarding screen', (WidgetTester tester) async {
    // Mock SharedPreferences
    SharedPreferences.setMockInitialValues({'isFirstLaunch': true});
    
    // Build our app and trigger a frame
    // await tester.pumpWidget(const MyApp(isFirstLaunch: true));
    
    // Verify that the onboarding screen is shown
    expect(find.byType(PageView), findsOneWidget);
  });
  
  testWidgets('App starts with home screen when not first launch', (WidgetTester tester) async {
    // Mock SharedPreferences
    SharedPreferences.setMockInitialValues({'isFirstLaunch': false});
    
    // Build our app and trigger a frame
    // await tester.pumpWidget(const MyApp(isFirstLaunch: false));
    
    // Verify that the home screen is shown
    expect(find.text('كلية الهندسة و تقنية المعلومات'), findsOneWidget);
  });
}
