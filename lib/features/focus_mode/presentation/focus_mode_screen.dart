import 'dart:async';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/utilities/duration_formatter.dart';
import '../../../shared/widgets/app_card.dart';

class FocusModeScreen extends ConsumerStatefulWidget {
  const FocusModeScreen({super.key});

  @override
  ConsumerState<FocusModeScreen> createState() => _FocusModeScreenState();
}

class _FocusModeScreenState extends ConsumerState<FocusModeScreen> {
  int _selectedDurationMinutes = 25;
  String _sessionTitle = 'Deep Work Session';
  bool _isActive = false;
  int _secondsRemaining = 0;
  Timer? _timer;

  final List<int> _durationOptions = [15, 25, 45, 60, 90];
  final List<String> _categories = ['Deep Work Session', 'Study & Research', 'Writing & Journaling', 'Reading Session'];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startSession() {
    setState(() {
      _isActive = true;
      _secondsRemaining = _selectedDurationMinutes * 60;
    });

    final db = ref.read(appDatabaseProvider);
    db.insertFocusSession(
      FocusSessionsCompanion(
        title: drift.Value(_sessionTitle),
        durationMinutes: drift.Value(_selectedDurationMinutes),
        startedAt: drift.Value(DateTime.now()),
        status: const drift.Value('active'),
      ),
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        _endSession(completed: true);
      }
    });
  }

  void _endSession({bool completed = false}) {
    _timer?.cancel();
    setState(() => _isActive = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            completed ? 'Focus session completed! Great job.' : 'Focus session stopped.',
          ),
          backgroundColor: completed ? AppColors.success : AppColors.warning,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double progress = _isActive && _selectedDurationMinutes > 0
        ? (1.0 - (_secondsRemaining / (_selectedDurationMinutes * 60))).clamp(0.0, 1.0)
        : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Focus Mode'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          // Visual Timer Card
          AppCard(
            gradient: AppColors.cardGradient,
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  width: 220,
                  height: 220,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(
                          value: _isActive ? progress : 0.0,
                          strokeWidth: 10,
                          backgroundColor: Colors.white.withOpacity(0.08),
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryCyan),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _isActive ? Icons.self_improvement_rounded : Icons.hourglass_empty_rounded,
                            size: 36,
                            color: AppColors.primaryCyan,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _isActive
                                ? DurationFormatter.formatCompact(_secondsRemaining)
                                : '$_selectedDurationMinutes:00',
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 34,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _isActive ? _sessionTitle : 'Ready to start',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondaryDark,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                if (!_isActive)
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                    ),
                    onPressed: _startSession,
                    icon: const Icon(Icons.play_arrow_rounded, size: 24),
                    label: const Text('Start Focus Session'),
                  )
                else
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.danger,
                      side: const BorderSide(color: AppColors.danger),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    ),
                    onPressed: () => _endSession(completed: false),
                    icon: const Icon(Icons.stop_rounded, size: 22),
                    label: const Text('Cancel Session'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          if (!_isActive) ...[
            Text('Session Duration', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _durationOptions.map((mins) {
                final isSelected = _selectedDurationMinutes == mins;
                return ChoiceChip(
                  label: Text('${mins}m'),
                  selected: isSelected,
                  onSelected: (_) => setState(() => _selectedDurationMinutes = mins),
                  selectedColor: AppColors.primaryCyan.withOpacity(0.2),
                  backgroundColor: AppColors.darkCard,
                  side: BorderSide(
                    color: isSelected ? AppColors.primaryCyan : AppColors.darkBorder,
                  ),
                  labelStyle: TextStyle(
                    color: isSelected ? AppColors.primaryCyan : AppColors.textSecondaryDark,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            Text('Session Purpose', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Column(
              children: _categories.map((cat) {
                final isSelected = _sessionTitle == cat;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AppCard(
                    onTap: () => setState(() => _sessionTitle = cat),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    backgroundColor: isSelected ? AppColors.primaryCyan.withOpacity(0.12) : null,
                    border: isSelected ? Border.all(color: AppColors.primaryCyan) : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cat, style: Theme.of(context).textTheme.titleLarge),
                        if (isSelected)
                          const Icon(Icons.check_circle_rounded, color: AppColors.primaryCyan, size: 20),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

