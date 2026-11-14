import 'package:drift/drift.dart';
import 'monitored_apps_table.dart';

class EmergencyUnlocks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get monitoredAppId => integer().references(MonitoredApps, #id)();
  DateTimeColumn get requestedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get expiresAt => dateTime()();
  TextColumn get reason => text()();
  TextColumn get status => text().withDefault(const Constant('active'))(); // active, expired, revoked
}

