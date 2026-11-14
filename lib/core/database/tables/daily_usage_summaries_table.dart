import 'package:drift/drift.dart';
import 'monitored_apps_table.dart';

class DailyUsageSummaries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get monitoredAppId => integer().references(MonitoredApps, #id)();
  DateTimeColumn get usageDate => dateTime()();
  IntColumn get totalDurationSeconds => integer().withDefault(const Constant(0))();
}

