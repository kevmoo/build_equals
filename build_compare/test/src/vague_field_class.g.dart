// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vague_field_class.dart';

// **************************************************************************
// BuildCompareGenerator
// **************************************************************************

int _buildCompareHashCombine(int hash, int value) {
  hash = 0x1fffffff & (hash + value);
  hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
  return hash ^ (hash >> 6);
}

int _buildCompareHashFinish(int hash) {
  hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
  hash = hash ^ (hash >> 11);
  return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
}

mixin _$VagueFieldClassCompare implements Comparable<VagueFieldClass> {
  Object get objectValue;

  dynamic get dynamicValue;

  @override
  bool operator ==(Object other) =>
      other is VagueFieldClass &&
      objectValue == other.objectValue &&
      dynamicValue == other.dynamicValue;

  @override
  int get hashCode {
    var hash = 0;
    hash = _buildCompareHashCombine(hash, objectValue.hashCode);
    hash = _buildCompareHashCombine(hash, dynamicValue.hashCode);
    return _buildCompareHashFinish(hash);
  }

  @override
  int compareTo(VagueFieldClass other) => 0;
}
