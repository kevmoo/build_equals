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

class BuildCompareField {
  /// Defaults to `null` - which means the field name is taken into
  /// consideration.
  final bool equalsAndHashCode;

  /// Valid values are `null`, `true`, `false` or an [int].
  ///
  /// `null`: This field will be used in comparisons if the class setting is
  /// enabled and the type of the field is [Comparable], and there isn't a
  /// seemingly duplicate field with different privacy setting.
  final dynamic compareTo;

  const BuildCompareField({
    this.equalsAndHashCode,
    this.compareTo,
  });
}
