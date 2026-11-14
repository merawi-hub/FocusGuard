import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/status_badge.dart';

class DailyRoutinesScreen extends ConsumerStatefulWidget {
  const DailyRoutinesScreen({super.key});

  @override
  ConsumerState<DailyRoutinesScreen> createState() => _DailyRoutinesScreenState();
}

class _DailyRoutinesScreenState extends ConsumerState<DailyRoutinesScreen> {
  final _titleController = TextEditingController();
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 17, minute: 0);
  final List<String> _selectedDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _showAddRoutineDialog(BuildContext context) {
    _titleController.clear();
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: AppColors.darkCard,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text('Add Daily Routine'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Routine Title',
                    hintText: 'e.g. Deep Study Time, Sleep Routine',
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Start Time:'),
                    TextButton(
                      onPressed: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: _startTime,
                        );
                        if (time != null) {
                          setDialogState(() => _startTime = time);
                        }
                      },
                      child: Text(_startTime.format(context)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('End Time:'),
                    TextButton(
                      onPressed: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: _endTime,
                        );
                        if (time != null) {
                          setDialogState(() => _endTime = time);
                        }
                      },
                      child: Text(_endTime.format(context)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text('Active Days:', style: TextStyle(fontSize: 12)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((day) {
                    final isSelected = _selectedDays.contains(day);
                    return ChoiceChip(
                      label: Text(day),
                      selected: isSelected,
                      onSelected: (val) {
                        setDialogState(() {
                          if (val) {
                            _selectedDays.add(day);
                          } else if (_selectedDays.length > 1) {
                            _selectedDays.remove(day);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final title = _titleController.text.trim();
                Navigator.of(ctx).pop();
                if (title.isNotEmpty) {
                  final db = ref.read(appDatabaseProvider);
                  await db.insertRoutine(
                    DailyRoutinesCompanion(
                      title: drift.Value(title),
                      startTime: drift.Value('${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}'),
                      endTime: drift.Value('${_endTime.hour.toString().padLeft(2, '0')}:${_endTime.minute.toString().padLeft(2, '0')}'),
                      selectedDays: drift.Value(_selectedDays.join(',')),
                      isEnabled: const drift.Value(true),
                    ),
                  );
                }
              },
              child: const Text('Save Routine'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final routinesAsync = ref.watch(dailyRoutinesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Routines & Schedules'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            tooltip: 'Add routine schedule',
            onPressed: () => _showAddRoutineDialog(context),
          ),
        ],
      ),
      body: routinesAsync.when(
        data: (routines) {
          if (routines.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.schedule_rounded, size: 54, color: AppColors.textMutedDark),
                  const SizedBox(height: 16),
                  Text('No Routines Configured', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Text(
                    'Create recurring study, workout, or sleep schedules to protect your focus automatically.',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => _showAddRoutineDialog(context),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Create Routine Schedule'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: routines.length,
            itemBuilder: (context, index) {
              final routine = routines[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AppCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primaryCyan.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.access_time_filled_rounded,
                          color: AppColors.primaryCyan,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(routine.title, style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 4),
                            Text(
                              '${routine.startTime} - ${routine.endTime}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.primaryCyan,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            StatusBadge(
                              label: routine.selectedDays,
                              color: AppColors.textSecondaryDark,
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: routine.isEnabled,
                        onChanged: (val) {
                          final db = ref.read(appDatabaseProvider);
                          db.updateRoutine(routine.copyWith(isEnabled: val));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded, size: 20, color: AppColors.textMutedDark),
                        onPressed: () {
                          final db = ref.read(appDatabaseProvider);
                          db.deleteRoutine(routine.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primaryCyan)),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

