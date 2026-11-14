import 'package:drift/drift.dart';

class MonitoredApps extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get platformAppId => text().unique()();
  TextColumn get appName => text()();
  TextColumn get iconReference => text().nullable()();
  BoolColumn get isMonitored => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

