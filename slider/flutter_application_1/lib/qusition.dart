import 'package:flutter/material.dart';

class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class Qusition extends StatefulWidget {
  const Qusition({super.key});

  @override
  State<Qusition> createState() => _QusitionState();
}

class _QusitionState extends State<Qusition> {
  // Large pool of questions
  final List<Question> _allQuestions = [
    Question(
      question: 'ما هي عاصمة المملكة العربية السعودية؟',
      options: ['جدة', 'الرياض', 'الدمام', 'مكة المكرمة'],
      correctAnswerIndex: 1,
    ),
    Question(
      question: 'ما هو أطول نهر في العالم؟',
      options: ['نهر النيل', 'نهر الأمازون', 'نهر اليانغتسي', 'نهر المسيسيبي'],
      correctAnswerIndex: 0,
    ),
    Question(
      question: 'ما هي أكبر قارة في العالم من حيث المساحة؟',
      options: ['أفريقيا', 'أمريكا الشمالية', 'آسيا', 'أوروبا'],
      correctAnswerIndex: 2,
    ),
    Question(
      question: 'ما هو العنصر الكيميائي الذي رمزه Au؟',
      options: ['الفضة', 'النحاس', 'الذهب', 'الألومنيوم'],
      correctAnswerIndex: 2,
    ),
    Question(
      question: 'من هو مخترع المصباح الكهربائي؟',
      options: ['نيوتن', 'أينشتاين', 'توماس إديسون', 'جاليليو'],
      correctAnswerIndex: 2,
    ),
    Question(
      question: 'ما هي لغة البرازيل الرسمية؟',
      options: ['الإسبانية', 'الإنجليزية', 'البرتغالية', 'الفرنسية'],
      correctAnswerIndex: 2,
    ),
    Question(
      question: 'ما هو أسرع حيوان بري في العالم؟',
      options: ['الفهد', 'الأسد', 'النمر', 'الغزال'],
      correctAnswerIndex: 0,
    ),
    Question(
      question: 'كم عدد ألوان قوس قزح؟',
      options: ['5', '6', '7', '8'],
      correctAnswerIndex: 2,
    ),
    Question(
      question: 'ما هي أكبر محيطات العالم؟',
      options: ['المحيط الأطلسي', 'المحيط الهادئ', 'المحيط الهندي', 'المحيط المتجمد الشمالي'],
      correctAnswerIndex: 1,
    ),
    Question(
      question: 'من هو مؤلف كتاب "القرآن الكريم"؟',
      options: ['النبي محمد ﷺ', 'أبو بكر الصديق', 'عمر بن الخطاب', 'عثمان بن عفان'],
      correctAnswerIndex: 0,
    ),
    // Add more questions to the pool
    Question(
      question: 'ما هي عاصمة فرنسا؟',
      options: ['لندن', 'برلين', 'باريس', 'مدريد'],
      correctAnswerIndex: 2,
    ),
    Question(
      question: 'ما هو الكوكب الأقرب إلى الشمس؟',
      options: ['الزهرة', 'عطارد', 'الأرض', 'المريخ'],
      correctAnswerIndex: 1,
    ),
    Question(
      question: 'ما هي لغة النمسا الرسمية؟',
      options: ['الإنجليزية', 'الفرنسية', 'الألمانية', 'الإيطالية'],
      correctAnswerIndex: 2,
    ),
    Question(
      question: 'ما هو أطول جبل في العالم؟',
      options: ['كليمنجارو', 'إيفرست', 'كليمنجارو', 'كي 2'],
      correctAnswerIndex: 1,
    ),
    Question(
      question: 'ما هو العنصر الكيميائي الذي رمزه O؟',
      options: ['الذهب', 'الأكسجين', 'الأوزون', 'الأوزميوم'],
      correctAnswerIndex: 1,
    ),
  ];
  
  // This will hold the current set of questions
  late List<Question> _questions;
  
  // Track used question indices to avoid repetition
  final Set<int> _usedQuestionIndices = {};

  late List<int?> _selectedAnswers;
  bool _showResults = false;

  @override
  void initState() {
    super.initState();
    _selectRandomQuestions();
  }
  
  void _selectRandomQuestions() {
    // Reset used questions if we've used most of them
    if (_usedQuestionIndices.length >= _allQuestions.length - 5) {
      _usedQuestionIndices.clear();
    }
    
    // Create a list of available question indices
    final availableIndices = List.generate(
      _allQuestions.length, 
      (index) => index
    )..removeWhere((index) => _usedQuestionIndices.contains(index));
    
    // Shuffle and take first 10 (or less if not enough available)
    availableIndices.shuffle();
    final selectedIndices = availableIndices.take(10).toList();
    
    // Mark these questions as used
    _usedQuestionIndices.addAll(selectedIndices);
    
    // Set the questions for this quiz
    _questions = selectedIndices.map((index) => _allQuestions[index]).toList();
    
    // Initialize selected answers
    _selectedAnswers = List.filled(_questions.length, null);
    _showResults = false;
  }

  int _calculateScore() {
    int score = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] == _questions[i].correctAnswerIndex) {
        score++;
      }
    }
    return score;
  }

  void _submitAnswers() {
    setState(() {
      _showResults = true;
    });
  }

  void _resetQuiz() {
    setState(() {
      _selectRandomQuestions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختبار المعلومات العامة'),
        centerTitle: true,
      ),
      body: _showResults
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'النتيجة النهائية',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 4,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${_calculateScore()}/${_questions.length}',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Text(
                        'إجابات صحيحة: ${_calculateScore()}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'إجابات خاطئة: ${_questions.length - _calculateScore()}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _resetQuiz,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: const Text(
                      'إعادة الاختبار',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  final question = _questions[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ${question.question}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...question.options.asMap().entries.map((option) {
                            final isSelected = _selectedAnswers[index] == option.key;
                            final isCorrect = option.key == question.correctAnswerIndex;
                            
                            Widget? trailing;
                            if (_showResults) {
                              if (isCorrect) {
                                trailing = const Icon(Icons.check_circle, color: Colors.green);
                              } else if (isSelected) {
                                trailing = const Icon(Icons.cancel, color: Colors.red);
                              }
                            }

                            return RadioListTile<int>(
                              title: Text(option.value),
                              value: option.key,
                              groupValue: _selectedAnswers[index],
                              onChanged: _showResults
                                  ? null
                                  : (value) {
                                      setState(() {
                                        _selectedAnswers[index] = value;
                                      });
                                    },
                              activeColor: _showResults
                                  ? (isCorrect ? Colors.green : Colors.red)
                                  : null,
                              secondary: trailing,
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (!_showResults)
              ElevatedButton(
                onPressed: _selectedAnswers.every((answer) => answer != null)
                    ? _submitAnswers
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text(
                  'إظهار النتيجة',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            const SizedBox(height: 16),
            if (_showResults) const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
