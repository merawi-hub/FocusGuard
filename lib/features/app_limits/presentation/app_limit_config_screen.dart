import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/utilities/duration_formatter.dart';
import '../../../shared/models/platform_app.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_icon_avatar.dart';
import '../../restrictions/providers/restriction_coordinator_provider.dart';

class AppLimitConfigScreen extends ConsumerStatefulWidget {
  final PlatformApp app;

  const AppLimitConfigScreen({
    super.key,
    required this.app,
  });

  @override
  ConsumerState<AppLimitConfigScreen> createState() => _AppLimitConfigScreenState();
}

class _AppLimitConfigScreenState extends ConsumerState<AppLimitConfigScreen> {
  late int _limitMinutes;
  bool _enforceStrict = true;
  bool _limitEnabled = true;
  final Set<int> _selectedThresholds = {50, 80, 100};
  bool _isSaving = false;

  final List<int> _presetMinutes = [15, 30, 45, 60, 90, 120, 180];

  @override
  void initState() {
    super.initState();
    _limitMinutes = widget.app.dailyLimitSeconds != null && widget.app.dailyLimitSeconds! > 0
        ? (widget.app.dailyLimitSeconds! ~/ 60)
        : 30; // default 30 mins
  }

  Future<void> _saveLimit() async {
    setState(() => _isSaving = true);
    final db = ref.read(appDatabaseProvider);

    // Look up or insert monitored app record
    var dbApp = await db.getMonitoredAppByPackage(widget.app.packageName);
    int monitoredId;
    if (dbApp == null) {
      monitoredId = await db.insertMonitoredApp(
        MonitoredAppsCompanion(
          platformAppId: drift.Value(widget.app.packageName),
          appName: drift.Value(widget.app.appName),
          iconReference: drift.Value(widget.app.iconBase64),
          isMonitored: const drift.Value(true),
        ),
      );
    } else {
      monitoredId = dbApp.id;
    }

    // Upsert limit
    await db.upsertLimit(
      AppLimitsCompanion(
        monitoredAppId: drift.Value(monitoredId),
        dailyLimitSeconds: drift.Value(_limitMinutes * 60),
        warningThresholds: drift.Value(_selectedThresholds.toList().toString()),
        enforcementMode: drift.Value(_enforceStrict ? 'strict' : 'soft'),
        isEnabled: drift.Value(_limitEnabled),
      ),
    );

    // Trigger restriction evaluation
    final coordinator = ref.read(restrictionCoordinatorProvider);
    await coordinator.evaluateAndEnforce();

    setState(() => _isSaving = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Daily limit for ${widget.app.appName} set to $_limitMinutes mins'),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configure Limit: ${widget.app.appName}'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          // App Header Card
          AppCard(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                AppIconAvatar(
                  iconBytes: widget.app.iconBytes,
                  appName: widget.app.appName,
                  size: 56,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.app.appName,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.app.packageName,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Today: ${DurationFormatter.formatSeconds(widget.app.todayUsageSeconds)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.primaryCyan,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Enable Limit Toggle
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Enforce Daily Limit', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 2),
                    Text('Restrict app once limit is exhausted', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                Switch(
                  value: _limitEnabled,
                  onChanged: (val) => setState(() => _limitEnabled = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          if (_limitEnabled) ...[
            // Duration Configuration
            Text('Daily Allowance', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            AppCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      DurationFormatter.formatMinutes(_limitMinutes),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: AppColors.primaryCyan,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Slider(
                    value: _limitMinutes.toDouble(),
                    min: 5,
                    max: 300,
                    divisions: 59, // 5 min increments
                    activeColor: AppColors.primaryCyan,
                    inactiveColor: AppColors.darkBorder,
                    onChanged: (val) => setState(() => _limitMinutes = val.toInt()),
                  ),
                  const SizedBox(height: 12),
                  // Quick Presets
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _presetMinutes.map((mins) {
                      final isSelected = _limitMinutes == mins;
                      return ChoiceChip(
                        label: Text('${mins}m'),
                        selected: isSelected,
                        onSelected: (_) => setState(() => _limitMinutes = mins),
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
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Warning Thresholds
            Text('Warning Notifications', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 6),
            Text(
              'Select percentage milestones to receive gentle reminders before locking.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            AppCard(
              padding: const EdgeInsets.all(18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [50, 80, 100].map((th) {
                  final isChecked = _selectedThresholds.contains(th);
                  return FilterChip(
                    label: Text('$th% Warning'),
                    selected: isChecked,
                    onSelected: (val) {
                      setState(() {
                        if (val) {
                          _selectedThresholds.add(th);
                        } else if (_selectedThresholds.length > 1) {
                          _selectedThresholds.remove(th);
                        }
                      });
                    },
                    selectedColor: AppColors.primaryCyan.withOpacity(0.25),
                    side: BorderSide(
                      color: isChecked ? AppColors.primaryCyan : AppColors.darkBorder,
                    ),
                    labelStyle: TextStyle(
                      color: isChecked ? AppColors.primaryCyan : AppColors.textSecondaryDark,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Enforcement Mode
            Text('Enforcement Mode', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            AppCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  RadioListTile<bool>(
                    title: const Text('Strict Shield (Recommended)'),
                    subtitle: const Text('Brings up the FocusGuard blocking screen immediately when opened.'),
                    value: true,
                    groupValue: _enforceStrict,
                    activeColor: AppColors.primaryCyan,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (val) => setState(() => _enforceStrict = val!),
                  ),
                  const Divider(color: AppColors.darkBorder),
                  RadioListTile<bool>(
                    title: const Text('Soft Advisory'),
                    subtitle: const Text('Issues persistent notifications without blocking the screen.'),
                    value: false,
                    groupValue: _enforceStrict,
                    activeColor: AppColors.primaryCyan,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (val) => setState(() => _enforceStrict = val!),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 36),

          ElevatedButton(
            onPressed: _isSaving ? null : _saveLimit,
            child: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                : const Text('Save Configuration'),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

