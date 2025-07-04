import 'dart:ui';
import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:sendtrain/models/training_form/training_form_model.dart';
import 'package:sendtrain/providers/app_state_provider.dart';
import 'package:sendtrain/services/firestore_service.dart';
import 'package:sendtrain/services/subscriptions_service.dart';
import 'package:sendtrain/widgets/shared/background_container.dart';
import 'package:sendtrain/providers/program_provider.dart';
import 'package:sendtrain/services/notification_service.dart';

class TrainingForm extends ConsumerStatefulWidget {
  const TrainingForm({super.key});

  @override
  ConsumerState<TrainingForm> createState() => _TrainingFormState();
}

class _TrainingFormState extends ConsumerState<TrainingForm> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Placeholder for form data
  final Map<String, dynamic> _formData = {};

  // Text controllers for form fields
  late final TextEditingController _goalController;
  late final TextEditingController _restrictionsController;
  late final TextEditingController _anythingElseController;
  late final TextEditingController _injuriesController;

  @override
  void initState() {
    super.initState();
    _goalController = TextEditingController();
    _restrictionsController = TextEditingController();
    _anythingElseController = TextEditingController();
    _injuriesController = TextEditingController();

    // Sync text controllers after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncTextControllers();
    });
  }

  @override
  void dispose() {
    _goalController.dispose();
    _restrictionsController.dispose();
    _anythingElseController.dispose();
    _injuriesController.dispose();
    super.dispose();
  }

  late final List<_QuestionModel> _questions = [
    _QuestionModel(
      null,
      (onChanged) => Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Text(
                'What is your age?',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _AgeSelector(
                onChanged: (age) => onChanged('age', age),
                initialAge: _formData['age'] ?? 30,
              ),
              Spacer(),
              Text(
                'What is your gender?',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _CustomChipSelector(
                options: ['Male', 'Female', 'Other', 'Prefer not to say'],
                onSelectionChanged: (selected) => onChanged(
                  'gender',
                  selected.isNotEmpty ? selected.first : null,
                ),
                allowMultiple: false,
                initialSelection: _formData['gender'] != null
                    ? [_formData['gender']]
                    : [],
              ),
              Spacer(flex: 2),
            ],
          );
        },
      ),
    ),
    _QuestionModel(
      null,
      (onChanged) => Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                'How many years have you been climbing?',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _CustomChipSelector(
                options: const ['<1', '1-3', '3-5', '5-7', '7-10', '10+'],
                onSelectionChanged: (selected) => onChanged(
                  'climbing_years',
                  selected.isNotEmpty ? selected.first : null,
                ),
                allowMultiple: false,
                initialSelection: _formData['climbing_years'] != null
                    ? [_formData['climbing_years']]
                    : [],
              ),
              const Spacer(),
              Text(
                'How many days per week do you currently climb?',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _CustomChipSelector(
                options: const ['0', '1-2', '3-4', '5+'],
                onSelectionChanged: (selected) => onChanged(
                  'climbing_days_per_week',
                  selected.isNotEmpty ? selected.first : null,
                ),
                allowMultiple: false,
                initialSelection: _formData['climbing_days_per_week'] != null
                    ? [_formData['climbing_days_per_week']]
                    : [],
              ),
              const Spacer(flex: 2),
            ],
          );
        },
      ),
    ),
    _QuestionModel(
      " Current level",
      (onChanged) => Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Bouldering", style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 24),
              _GradeSelectorRow(
                title: "Onsight",
                grades: _vGrades,
                onGradeSelected: (grade) => onChanged('boulder_onsight', grade),
                initialGrade: _formData['boulder_onsight'],
              ),
              const SizedBox(height: 24),
              _GradeSelectorRow(
                title: "Redpoint",
                grades: _vGrades,
                onGradeSelected: (grade) =>
                    onChanged('boulder_redpoint', grade),
                initialGrade: _formData['boulder_redpoint'],
              ),
              Spacer(),
              Text(
                "Sport Climbing",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              _GradeSelectorRow(
                title: "Onsight",
                grades: _yosemiteGrades,
                onGradeSelected: (grade) => onChanged('sport_onsight', grade),
                initialGrade: _formData['sport_onsight'],
              ),
              const SizedBox(height: 24),
              _GradeSelectorRow(
                title: "Redpoint",
                grades: _yosemiteGrades,
                onGradeSelected: (grade) => onChanged('sport_redpoint', grade),
                initialGrade: _formData['sport_redpoint'],
              ),
              Spacer(flex: 2),
            ],
          );
        },
      ),
      hasFullWidthContent: true,
    ),
    _QuestionModel(
      'Describe Your Goal',

      (onChanged) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Be as detailed as possible',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _goalController,
            onChanged: (text) => onChanged('goal_description', text),
            maxLines: 10,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText:
                  '"I want to send my first 5.12a project outdoors this season."\n\n "I\'d like to improve my finger strength." \n\n "I want to get better at overhangs." \n\n "I want to send my project, it has these characteristics... ',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    ),
    _QuestionModel(
      'Restrictions',
      (onChanged) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'List anything that might affect your training.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _restrictionsController,
            onChanged: (text) => onChanged('restrictions', text),
            maxLines: 12,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText:
                  '"I can only climb on mon, wed, fri."\n\n"I can only train at home and have these items..."\n\n"I can only train twice per week."\n\n"I have a job that requires me to travel a lot."\n\n"I have kids I have to watch',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    ),
    _QuestionModel(
      'Anything else?',
      (onChanged) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  'Personal considerations to customize your training system',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _anythingElseController,
            onChanged: (text) => onChanged('anything_else', text),
            maxLines: 12,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText:
                  '"I like to climb outside on weekends"\n\n"I dont want to loose power"\n\n"I usually find most training boring"\n\n"My gym has these things im interested in using"\n\n"Im intimidated"',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    ),
    _QuestionModel(
      'Any injuries or things to avoid?',
      (onChanged) => TextField(
        controller: _injuriesController,
        onChanged: (text) => onChanged('injuries', text),
        maxLines: 3,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'e.g., Left shoulder, right finger tendon',
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ),
    _QuestionModel(
      'How many weeks should the plan last?',
      (onChanged) => _CustomChipSelector(
        options: const ["4", "6", '8', '12', '16', '20', '24'],
        onSelectionChanged: (selected) {
          if (selected.isNotEmpty) {
            onChanged('planDurationWeeks', int.tryParse(selected.first));
          } else {
            onChanged('planDurationWeeks', null);
          }
        },
        allowMultiple: false,
        initialSelection: _formData['planDurationWeeks'] != null
            ? [_formData['planDurationWeeks'].toString()]
            : [],
      ),
    ),
  ];

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _updateFormData(String key, dynamic value) {
    setState(() {
      _formData[key] = value;
    });

    // Sync text controllers with form data
    _syncTextControllers();
  }

  bool _isCurrentPageValid() {
    switch (_currentPage) {
      case 0: // Age and Gender page
        return _formData['age'] != null;
      case 1: // Climbing experience page
        return _formData['climbing_years'] != null &&
            _formData['climbing_days_per_week'] != null;
      case 2: // Current level page (optional)
        return true;
      case 3: // Goal description page
        return _formData['goal_description'] != null &&
            _formData['goal_description'].toString().trim().isNotEmpty;
      case 4: // Restrictions page (optional)
        return true;
      case 5: // Anything else page (optional)
        return true;
      case 6: // Injuries page (optional)
        return true;
      case 7: // Plan duration page
        return _formData['planDurationWeeks'] != null;
      default:
        return true;
    }
  }

  void _syncTextControllers() {
    if (_formData['goal_description'] != null &&
        _goalController.text != _formData['goal_description']) {
      _goalController.text = _formData['goal_description'];
    }
    if (_formData['restrictions'] != null &&
        _restrictionsController.text != _formData['restrictions']) {
      _restrictionsController.text = _formData['restrictions'];
    }
    if (_formData['anything_else'] != null &&
        _anythingElseController.text != _formData['anything_else']) {
      _anythingElseController.text = _formData['anything_else'];
    }
    if (_formData['injuries'] != null &&
        _injuriesController.text != _formData['injuries']) {
      _injuriesController.text = _formData['injuries'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Fixed background that doesn't move with keyboard
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0A092D), Color(0xFF1F1E3D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -150,
                    left: -150,
                    child: buildBlurryCircle(
                      context,
                      theme.colorScheme.primary.withOpacity(0.2),
                      450,
                    ),
                  ),
                  Positioned(
                    bottom: -150,
                    right: -150,
                    child: buildBlurryCircle(
                      context,
                      theme.colorScheme.secondary.withOpacity(0.05),
                      450,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Scrollable content on top
          SafeArea(
            child: Column(
              children: [
                AppBar(
                  leading: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Exit',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  leadingWidth: 100,
                  automaticallyImplyLeading: false,
                  title: const Text('About You'),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: _GradientProgressBar(
                    progress: (_currentPage + 1) / _questions.length,
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: _onPageChanged,
                    itemCount: _questions.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        child: SizedBox(
                          height:
                              MediaQuery.of(context).size.height -
                              MediaQuery.of(context).viewInsets.bottom -
                              200,
                          child: _QuestionCard(
                            question: _questions[index].question,
                            hasFullWidthContent:
                                _questions[index].hasFullWidthContent,
                            child: _questions[index].answerWidgetBuilder(
                              _updateFormData,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: ref.watch(appStateProvider).isGeneratingPlan
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom > 0
                    ? 16.0
                    : 0.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_currentPage > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          // Dismiss keyboard before navigation
                          FocusScope.of(context).unfocus();
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                        heroTag: 'back_button',
                        backgroundColor: theme.colorScheme.surface,
                        child: Icon(
                          Icons.arrow_back,
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                    ),
                  Spacer(),
                  Hero(
                    tag: 'next_button',
                    child: _GradientButton(
                      onPressed: _isCurrentPageValid()
                          ? () {
                              // Dismiss keyboard before navigation
                              FocusScope.of(context).unfocus();
                              if (_currentPage < _questions.length - 1) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                              } else {
                                _submitForm();
                              }
                            }
                          : null,
                      isEnabled: _isCurrentPageValid(),
                      label: Text(
                        _currentPage < _questions.length - 1
                            ? 'Next'
                            : 'Finish',
                        style: TextStyle(
                          color: _isCurrentPageValid()
                              ? Colors.white
                              : Colors.white54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: Icon(
                        _currentPage < _questions.length - 1
                            ? Icons.arrow_forward
                            : Icons.check,
                        color: _isCurrentPageValid()
                            ? Colors.white
                            : Colors.white54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _submitForm() async {
    // Basic validation
    if (_formData['goal_description'] == null ||
        _formData['planDurationWeeks'] == null ||
        _formData['age'] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill out age, goal, and plan duration to proceed.',
          ),
        ),
      );
      return;
    }

    final subscriptionsService = ref.read(subscriptionsServiceProvider);
    final isSubscribed = await subscriptionsService.isSubscribed();

    if (!isSubscribed) {
      await subscriptionsService.showPaywall();
      final isNowSubscribed = await subscriptionsService.isSubscribed();
      if (!isNowSubscribed) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('You must subscribe to create training plans.'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }
    }

    // Request notification permissions first
    ref.read(notificationServiceProvider).requestPermissions();

    // Set the generating state to true and navigate away immediately.
    ref.read(appStateProvider.notifier).setIsGeneratingPlan(true);
    Navigator.of(context).pop();

    try {
      // Data Transformation - Ensure correct types
      final Map<String, dynamic> userData = {
        'age': int.tryParse(_formData['age'].toString()) ?? 0,
        'gender': _formData['gender'],
        'goalDescription': _formData['goal_description'],
        'planDurationWeeks':
            int.tryParse(_formData['planDurationWeeks'].toString()) ?? 0,
        'boulderOnsight': _formData['boulder_onsight'],
        'boulderRedpoint': _formData['boulder_redpoint'],
        'sportOnsight': _formData['sport_onsight'],
        'sportRedpoint': _formData['sport_redpoint'],
        'restrictions': _formData['restrictions'],
        'anythingElse': _formData['anything_else'],
        'injuries': _formData['injuries'],
        'climbingYears': _formData['climbing_years'].toString(),
        'climbingDaysPerWeek': _formData['climbing_days_per_week'].toString(),
      };

      // Use the default Firebase Functions instance. The SDK should handle auth.
      print('🔄 Calling function with default Firebase SDK instance...');
      await FirebaseFunctions.instance
          .httpsCallable('generateClimbingProgram')
          .call(userData);
    } on FirebaseFunctionsException catch (e) {
      // This is an expected error when using the "fire and forget" approach.
      // The client-side SDK times out, but the cloud function continues running.
      if (e.code == 'deadline-exceeded') {
        print(
          '✅ Client timed out as expected. Function is running in the background.',
        );
        // Do nothing, this is the successful path for a long-running function.
      } else {
        // Handle other, unexpected Firebase Functions exceptions
        ref.read(appStateProvider.notifier).setIsGeneratingPlan(false);
        print(
          '❌ Function call failed with Firebase exception: ${e.code} - ${e.message}',
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('An error occurred: ${e.message}'),
              duration: const Duration(seconds: 5),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    } catch (error) {
      // Handle any other non-Firebase errors

      ref.read(appStateProvider.notifier).setIsGeneratingPlan(false);
      print('❌ Function call failed with a generic error: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An unexpected error occurred: ${error.toString()}'),
            duration: const Duration(seconds: 5),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}

class _QuestionModel {
  final String? question;
  final Widget Function(void Function(String, dynamic)) answerWidgetBuilder;
  final bool hasFullWidthContent;

  _QuestionModel(
    this.question,
    this.answerWidgetBuilder, {
    this.hasFullWidthContent = false,
  });
}

class _QuestionCard extends StatelessWidget {
  final String? question;
  final Widget child;
  final bool hasFullWidthContent;

  const _QuestionCard({
    required this.question,
    required this.child,
    this.hasFullWidthContent = false,
  });

  @override
  Widget build(BuildContext context) {
    final padding = hasFullWidthContent
        ? const EdgeInsets.fromLTRB(24, 24, 0, 24)
        : const EdgeInsets.all(24.0);
    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          question != null
              ? Column(
                  children: [
                    Text(
                      question!,
                      style: Theme.of(context).textTheme.headlineMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40),
                  ],
                )
              : const SizedBox.shrink(),

          Expanded(child: child),
        ],
      ),
    );
  }
}

class _CustomChipSelector extends StatefulWidget {
  final List<String> options;
  final Function(List<String>) onSelectionChanged;
  final bool allowMultiple;
  final List<String> initialSelection;

  const _CustomChipSelector({
    required this.options,
    required this.onSelectionChanged,
    this.allowMultiple = false,
    this.initialSelection = const [],
  });

  @override
  _CustomChipSelectorState createState() => _CustomChipSelectorState();
}

class _CustomChipSelectorState extends State<_CustomChipSelector> {
  late List<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List<String>.from(widget.initialSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: widget.options.map((option) {
        final isSelected = _selected.contains(option);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (widget.allowMultiple) {
                if (isSelected) {
                  _selected.remove(option);
                } else {
                  _selected.add(option);
                }
              } else {
                _selected.clear();
                _selected.add(option);
              }
            });
            widget.onSelectionChanged(_selected);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              option,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyLarge?.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _DaySelector extends StatefulWidget {
  final Function(int) onChanged;
  const _DaySelector({required this.onChanged});

  @override
  _DaySelectorState createState() => _DaySelectorState();
}

class _DaySelectorState extends State<_DaySelector> {
  int _selectedDay = 3;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final day = index + 1;
        final isSelected = day == _selectedDay;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDay = day;
            });
            widget.onChanged(day);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                day.toString(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _AgeSelector extends StatefulWidget {
  final Function(int) onChanged;
  final int initialAge;
  const _AgeSelector({required this.onChanged, this.initialAge = 30});

  @override
  _AgeSelectorState createState() => _AgeSelectorState();
}

class _AgeSelectorState extends State<_AgeSelector> {
  late int _age;

  @override
  void initState() {
    super.initState();
    _age = widget.initialAge;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onChanged(_age); // Set initial value
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepButton(context, '-5', () {
          setState(() => _age = (_age - 5).clamp(1, 100));
          widget.onChanged(_age);
        }),
        _buildCircleButton(context, Icons.remove, () {
          if (_age > 1) {
            setState(() => _age--);
            widget.onChanged(_age);
          }
        }),
        Expanded(
          child: Text(
            '$_age',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        _buildCircleButton(context, Icons.add, () {
          if (_age < 100) {
            setState(() => _age++);
            widget.onChanged(_age);
          }
        }),
        _buildStepButton(context, '+5', () {
          setState(() => _age = (_age + 5).clamp(1, 100));
          widget.onChanged(_age);
        }),
      ],
    );
  }

  Widget _buildCircleButton(
    BuildContext context,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Theme.of(context).textTheme.bodyLarge?.color),
      ),
    );
  }

  Widget _buildStepButton(
    BuildContext context,
    String label,
    VoidCallback onPressed,
  ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

const List<String> _vGrades = [
  'V0',
  'V1',
  'V2',
  'V3',
  'V4',
  'V5',
  'V6',
  'V7',
  'V8',
  'V9',
  'V10',
  'V11',
  'V12',
  'V13',
  'V14',
  'V15',
  'V16',
  'V17',
];

const List<String> _yosemiteGrades = [
  '5.6',
  '5.7',
  '5.8',
  '5.9',
  '5.10a',
  '5.10b',
  '5.10c',
  '5.10d',
  '5.11a',
  '5.11b',
  '5.11c',
  '5.11d',
  '5.12a',
  '5.12b',
  '5.12c',
  '5.12d',
  '5.13a',
  '5.13b',
  '5.13c',
  '5.13d',
  '5.14a',
  '5.14b',
  '5.14c',
  '5.14d',
  '5.15a',
  '5.15b',
  '5.15c',
  '5.15d',
];

class _GradeSelectorRow extends StatelessWidget {
  final String title;
  final List<String> grades;
  final Function(String) onGradeSelected;
  final String? initialGrade;

  const _GradeSelectorRow({
    required this.title,
    required this.grades,
    required this.onGradeSelected,
    this.initialGrade,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _GradeSelector(
            grades: grades,
            onGradeSelected: onGradeSelected,
            initialGrade: initialGrade,
          ),
        ),
      ],
    );
  }
}

class _GradeSelector extends StatefulWidget {
  final List<String> grades;
  final Function(String) onGradeSelected;
  final String? initialGrade;

  const _GradeSelector({
    required this.grades,
    required this.onGradeSelected,
    this.initialGrade,
  });

  @override
  _GradeSelectorState createState() => _GradeSelectorState();
}

class _GradeSelectorState extends State<_GradeSelector> {
  String? _selectedGrade;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedGrade = widget.initialGrade;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.grades.length,
        itemBuilder: (context, index) {
          final grade = widget.grades[index];
          final isSelected = _selectedGrade == grade;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedGrade = grade;
              });
              widget.onGradeSelected(grade);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                grade,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _GradientProgressBar extends StatelessWidget {
  final double progress;
  const _GradientProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 8,
        decoration: BoxDecoration(color: theme.colorScheme.surface),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              tween: Tween<double>(begin: 0, end: progress),
              builder: (context, animatedProgress, child) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: constraints.maxWidth * animatedProgress,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.secondary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget label;
  final Widget icon;
  final bool isEnabled;

  const _GradientButton({
    required this.onPressed,
    required this.label,
    required this.icon,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isEnabled
                ? [theme.colorScheme.primary, theme.colorScheme.primary]
                : [Colors.grey.shade600, Colors.grey.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [icon, const SizedBox(width: 8), label],
        ),
      ),
    );
  }
}
