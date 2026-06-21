/// Universal UI state sealed class.
///
/// Every feature bloc should expose one of these states
/// instead of ad-hoc boolean flags.
sealed class UiState<T> {
  const UiState();
}

class UiInitial<T> extends UiState<T> {
  const UiInitial();
}

class UiLoading<T> extends UiState<T> {
  const UiLoading();
}

class UiEmpty<T> extends UiState<T> {
  const UiEmpty();
}

class UiSuccess<T> extends UiState<T> {
  final T data;
  const UiSuccess(this.data);
}

class UiError<T> extends UiState<T> {
  final String message;
  final T? data;
  const UiError(this.message, {this.data});
}
