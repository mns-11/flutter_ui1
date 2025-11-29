import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercentIndicatorDemo extends StatelessWidget {
  const PercentIndicatorDemo({super.key});

  void _resetProgress(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const PercentIndicatorDemo()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('مؤشرات النسبة المئوية'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // مؤشر دائري
            CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 20.0,
              percent: 0.7,
              center: const Text(
                "70%",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              progressColor: Colors.blue,
              backgroundColor: Colors.grey[200]!,
              circularStrokeCap: CircularStrokeCap.round,
              animation: true,
              animationDuration: 1500,
            ),
            const SizedBox(height: 50),

            // مؤشر خطي
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 100,
              lineHeight: 20.0,
              percent: 0.5,
              center: const Text("50.0%"),
              barRadius: const Radius.circular(10),
              progressColor: Colors.green,
              backgroundColor: Colors.grey[200],
              animation: true,
              animationDuration: 1000,
            ),
            const SizedBox(height: 10),

            // مؤشر خطي متعدد الأجزاء
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 100,
              lineHeight: 30.0,
              percent: 1.0,
              barRadius: const Radius.circular(10),
              backgroundColor: Colors.grey[200]!,
              animation: true,
              animationDuration: 1000,
              linearGradient: const LinearGradient(
                colors: [
                  Colors.redAccent,
                  Colors.orangeAccent,
                  Colors.yellowAccent,
                ],
              ),
            ),

            const SizedBox(height: 30),

            // زر لإعادة تعيين الرسوم المتحركة
            ElevatedButton(
              onPressed: () => _resetProgress(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'إعادة التشغيل',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
