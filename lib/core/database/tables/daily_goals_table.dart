import 'package:drift/drift.dart';

class DailyGoals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn get targetMinutes => integer()();
  IntColumn get completedMinutes => integer().withDefault(const Constant(0))();
  DateTimeColumn get goalDate => dateTime()();
  TextColumn get status => text().withDefault(const Constant('active'))(); // active, achieved, missed
}

