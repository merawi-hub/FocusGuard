import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/platform/restriction_engine_provider.dart';
import '../domain/restriction_coordinator.dart';

final restrictionCoordinatorProvider = Provider<RestrictionCoordinator>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final engine = ref.watch(restrictionEngineProvider);
  return RestrictionCoordinator(database: db, engine: engine);
});

