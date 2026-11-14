import 'package:drift/drift.dart';

class FocusSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn get durationMinutes => integer()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  TextColumn get status => text().withDefault(const Constant('active'))(); // active, completed, cancelled
}

