extension HandleNullable on Object? {
  bool get isNull {
    if (this == null) return true;
    return false;
  }

  bool get isNotNull {
    if (this != null) return true;
    return false;
  }
}
