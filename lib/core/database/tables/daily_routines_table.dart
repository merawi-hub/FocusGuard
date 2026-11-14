import 'package:drift/drift.dart';

class DailyRoutines extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get startTime => text()(); // e.g., "08:00"
  TextColumn get endTime => text()();   // e.g., "17:00"
  TextColumn get selectedDays => text()(); // e.g., "Mon,Tue,Wed,Thu,Fri"
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
}

