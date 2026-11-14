import 'package:drift/drift.dart';
import 'monitored_apps_table.dart';

class AppLimits extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get monitoredAppId => integer().references(MonitoredApps, #id)();
  IntColumn get dailyLimitSeconds => integer()();
  TextColumn get warningThresholds => text().withDefault(const Constant('[50, 80, 100]'))();
  TextColumn get enforcementMode => text().withDefault(const Constant('strict'))();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
}

