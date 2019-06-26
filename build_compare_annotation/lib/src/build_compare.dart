class BuildCompare {
  /// Defaults to `true`.
  final bool getHashCode;

  /// Defaults to `true`.
  final bool equals;

  /// Defaults to `false`.
  final bool compareTo;

  const BuildCompare({
    bool getHashCode = true,
    bool equals = true,
    bool compareTo = false,
  })  : getHashCode = getHashCode ?? true,
        equals = equals ?? true,
        compareTo = compareTo ?? false;
}
