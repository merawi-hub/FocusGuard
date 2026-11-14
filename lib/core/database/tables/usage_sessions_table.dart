import 'package:drift/drift.dart';
import 'monitored_apps_table.dart';

class UsageSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get monitoredAppId => integer().references(MonitoredApps, #id)();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime()();
  IntColumn get durationSeconds => integer()();
  TextColumn get source => text().withDefault(const Constant('usage_stats'))();
}

