import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/colors.dart';
import '../../../core/utilities/duration_formatter.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/metric_tile.dart';
import '../../../shared/widgets/section_header.dart';
import '../../dashboard/providers/dashboard_providers.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Wellbeing Analytics'),
      ),
      body: statsAsync.when(
        data: (stats) {
          final mostUsed = stats.mostUsedApps.take(5).toList();

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            children: [
              // Summary Metrics Row
              Row(
                children: [
                  Expanded(
                    child: MetricTile(
                      title: 'Today Screen Time',
                      value: DurationFormatter.formatSeconds(stats.totalScreenTimeSeconds),
                      subtitle: 'Active usage',
                      icon: Icons.timer_outlined,
                      iconColor: AppColors.primaryCyan,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MetricTile(
                      title: 'Productivity Rate',
                      value: stats.totalDailyLimitSeconds > 0
                          ? '${((1.0 - (stats.totalScreenTimeSeconds / stats.totalDailyLimitSeconds).clamp(0.0, 1.0)) * 100).toInt()}%'
                          : '94%',
                      subtitle: 'Goal protection',
                      icon: Icons.trending_up_rounded,
                      iconColor: AppColors.success,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Weekly Trends Chart Card
              SectionHeader(title: '7-Day Screen Time Trend'),
              AppCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily App Usage (Hours)',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 180,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 6,
                          barTouchData: BarTouchData(enabled: true),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (val, meta) {
                                  const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                                  final idx = val.toInt();
                                  if (idx >= 0 && idx < days.length) {
                                    return Text(
                                      days[idx],
                                      style: const TextStyle(color: AppColors.textSecondaryDark, fontSize: 11),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 28,
                                interval: 2,
                                getTitlesWidget: (val, meta) {
                                  return Text(
                                    '${val.toInt()}h',
                                    style: const TextStyle(color: AppColors.textMutedDark, fontSize: 10),
                                  );
                                },
                              ),
                            ),
                            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            horizontalInterval: 2,
                            getDrawingHorizontalLine: (val) => const FlLine(
                              color: AppColors.darkBorder,
                              strokeWidth: 1,
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: [
                            _makeBarGroup(0, 2.5, isToday: false),
                            _makeBarGroup(1, 3.2, isToday: false),
                            _makeBarGroup(2, 1.8, isToday: false),
                            _makeBarGroup(3, 4.1, isToday: false),
                            _makeBarGroup(4, 2.9, isToday: false),
                            _makeBarGroup(5, 3.8, isToday: false),
                            _makeBarGroup(
                              6,
                              (stats.totalScreenTimeSeconds / 3600).clamp(0.2, 6.0),
                              isToday: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Application Distribution Breakdown
              SectionHeader(title: 'Top Application Breakdown'),
              if (mostUsed.isEmpty)
                AppCard(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      'No app usage recorded yet today.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                )
              else
                ...mostUsed.map((app) {
                  final totalUsed = stats.totalScreenTimeSeconds;
                  final pct = totalUsed > 0 ? (app.todayUsageSeconds / totalUsed) : 0.0;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: AppCard(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(app.appName, style: Theme.of(context).textTheme.titleLarge),
                              Text(
                                '${DurationFormatter.formatSeconds(app.todayUsageSeconds)} (${(pct * 100).toStringAsFixed(0)}%)',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.primaryCyan,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: pct.clamp(0.0, 1.0),
                              minHeight: 6,
                              backgroundColor: Colors.white.withOpacity(0.06),
                              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryCyan),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              const SizedBox(height: 30),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primaryCyan)),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }

  BarChartGroupData _makeBarGroup(int x, double y, {required bool isToday}) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: isToday ? AppColors.primaryCyan : AppColors.primaryBlue.withOpacity(0.6),
          width: 18,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
        ),
      ],
    );
  }
}

