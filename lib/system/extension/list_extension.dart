extension ListExtension on List<Object?>? {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
}
