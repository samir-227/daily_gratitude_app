abstract class Failure {
  final String message;
  const Failure(this.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class AudioFailure extends Failure {
  const AudioFailure(super.message);
}

class SpeechFailure extends Failure {
  const SpeechFailure(super.message);
}

class PermissionFailure extends Failure {
  const PermissionFailure(super.message);
}

class NotificationFailure extends Failure {
  const NotificationFailure(super.message);
}
