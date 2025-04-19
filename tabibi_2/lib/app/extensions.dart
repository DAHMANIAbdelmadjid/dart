extension NonNullString on String? {
  String onEmpty() {
    if (this == null) {
      return "No data";
    } else {
      return this!;
    }

  }
}
extension NonNullInt on int? {
  int onEmpty() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}
extension NonNullBool on bool? {
  bool onEmpty() {
    if (this == null) {
      return false;
    } else {
      return this!;
    }
  }
}