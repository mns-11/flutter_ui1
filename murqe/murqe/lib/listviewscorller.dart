import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

class Listviewscorller extends StatefulWidget {
  const Listviewscorller({super.key});

  @override
  State<Listviewscorller> createState() => _ListviewscorllerState();
}

class _ListviewscorllerState extends State<Listviewscorller> with TickerProviderStateMixin {
  // Rainbow gradient colors for each month
  final List<List<Color>> monthColors = [
    [const Color(0xFFFF0000), const Color(0xFFFF5E62)], // Red
    [const Color(0xFFFF8C00), const Color(0xFFFFB347)], // Orange
    [const Color(0xFFFFD700), const Color(0xFFFFEA00)], // Yellow
    [const Color(0xFF32CD32), const Color(0xFF7CFC00)], // Green
    [const Color(0xFF00BFFF), const Color(0xFF1E90FF)], // Light Blue
    [const Color(0xFF4169E1), const Color(0xFF0000FF)], // Blue
    [const Color(0xFF8A2BE2), const Color(0xFF9932CC)], // Indigo
    [const Color(0xFF8B00FF), const Color(0xFF9400D3)], // Violet
    [const Color(0xFFFF69B4), const Color(0xFFFF1493)], // Pink
    [const Color(0xFFFF4500), const Color(0xFFFF8C00)], // Red-Orange
    [const Color(0xFFFFD700), const Color(0xFFFFA500)], // Yellow-Orange
    [const Color(0xFF00FA9A), const Color(0xFF00FF7F)], // Green-Yellow
  ];
  
  // Animation controller
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;

  // Hijri months in Arabic
  final List<Map<String, String>> items = [
    {'title': 'محرم', 'subtitle': 'أول شهور السنة الهجرية'},
    {'title': 'صفر', 'subtitle': 'ثاني شهور السنة الهجرية'},
    {'title': 'ربيع الأول', 'subtitle': 'ثالث شهور السنة الهجرية'},
    {'title': 'ربيع الثاني', 'subtitle': 'رابع شهور السنة الهجرية'},
    {'title': 'جمادى الأولى', 'subtitle': 'خامس شهور السنة الهجرية'},
    {'title': 'جمادى الآخرة', 'subtitle': 'سادس شهور السنة الهجرية'},
    {'title': 'رجب', 'subtitle': 'سابع شهور السنة الهجرية'},
    {'title': 'شعبان', 'subtitle': 'ثامن شهور السنة الهجرية'},
    {'title': 'رمضان', 'subtitle': 'تاسع شهور السنة الهجرية'},
    {'title': 'شوال', 'subtitle': 'عاشر شهور السنة الهجرية'},
    {'title': 'ذو القعدة', 'subtitle': 'الحادي عشر من شهور السنة الهجرية'},
    {'title': 'ذو الحجة', 'subtitle': 'آخر شهور السنة الهجرية'},
  ];

  int _currentIndex = 0;
  int _currentHijriMonth = 1;
  final PageController _pageController = PageController(
    viewportFraction: 0.8,
  );
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    final hijriDate = HijriCalendar.now();
    _currentHijriMonth = hijriDate.hMonth;
    _currentIndex = _currentHijriMonth - 1; // Convert to 0-based index

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _fadeAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Jump to current month with animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(_currentIndex);
      _animationController.forward();
    });
  }

  // Helper method to get month name in Arabic
  String _getMonthName(int month) {
    final months = [
      '',
      'يناير',
      'فبراير',
      'مارس',
      'إبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    return months[month];
  }
  
  // Helper method to determine text color based on background brightness
  Color _getTextColor(Color backgroundColor) {
    final brightness = (backgroundColor.red * 299 + 
                       backgroundColor.green * 587 + 
                       backgroundColor.blue * 114) / 1000;
    return brightness > 155 ? Colors.black87 : Colors.white;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // Start auto-play method
  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentIndex < items.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE0F7FA),  // Light cyan
            Color(0xFFB2EBF2),  // Pale blue
            Color(0xFF80DEEA),  // Light teal
            Color(0xFF4DD0E1),  // Soft blue
          ],
          stops: [0.0, 0.3, 0.7, 1.0],
          tileMode: TileMode.mirror,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'أشهر السنة الهجرية',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: 300,
            child: PageView.builder(
              controller: _pageController,
              itemCount: items.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 1.0;
                    if (_pageController.position.haveDimensions) {
                      value = _pageController.page! - index;
                      value = (1 - (value.abs() * 0.3)).clamp(0.8, 1.0);
                    }
                    return Center(
                      child: SizedBox(
                        height: Curves.easeInOut.transform(value) * 300,
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        width: 300,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ScaleTransition(
                              scale: _currentHijriMonth - 1 == index 
                                  ? _fadeAnimation 
                                  : const AlwaysStoppedAnimation(1.0),
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: monthColors[index],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: monthColors[index][0].withOpacity(0.4),
                                      blurRadius: 15,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: _getTextColor(monthColors[index][0]),
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.1),
                                          offset: const Offset(1, 1),
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              items[index]['title']!,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: _currentHijriMonth - 1 == index
                                    ? Colors.black
                                    : Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              items[index]['subtitle']!,
                              style: TextStyle(
                                fontSize: 16,
                                color: _currentHijriMonth - 1 == index
                                    ? Colors.black87
                                    : Colors.grey[600],
                                fontWeight: _currentHijriMonth - 1 == index
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(items.length, (index) {
              return GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 4.0,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentHijriMonth - 1 == index
                        ? Theme.of(context)
                              .colorScheme
                              .secondary // Use theme's secondary color for current month
                        : Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.2),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 30),
          // Current date information
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.surface.withOpacity(0.9),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                  spreadRadius: 1,
                ),
              ],
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'التاريخ الهجري',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  HijriCalendar.now().toFormat('dd MMMM yyyy'),
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Divider(height: 30, thickness: 1),
                Text(
                  'التاريخ الميلادي',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${DateTime.now().day} ${_getMonthName(DateTime.now().month)} ${DateTime.now().year}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('الشهر الحالي: ${items[_currentIndex]["title"]}'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: const Icon(Icons.info_outline),
        ),
      ),
    );
  }
}
