class FocusGuardException implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  FocusGuardException(this.message, {this.code, this.details});

  @override
  String toString() => 'FocusGuardException($code): $message';
}

class PermissionDeniedException extends FocusGuardException {
  PermissionDeniedException(String permissionName)
      : super('Required permission was denied: $permissionName', code: 'PERMISSION_DENIED');
}

class PlatformNotSupportedException extends FocusGuardException {
  PlatformNotSupportedException(String feature)
      : super('Feature is not supported on this platform: $feature', code: 'PLATFORM_NOT_SUPPORTED');
}

class RestrictionException extends FocusGuardException {
  RestrictionException(super.message, {super.code, super.details});
}

