import 'package:drift/drift.dart';
import 'monitored_apps_table.dart';

class RestrictionEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get monitoredAppId => integer().references(MonitoredApps, #id)();
  TextColumn get eventType => text()(); // warning_sent, restriction_enforced, emergency_unlocked, restriction_restored
  DateTimeColumn get occurredAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get details => text().nullable()();
}

