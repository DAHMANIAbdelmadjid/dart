class Error{
  int code;
  String massage;
  Error(this.code, this.massage);
  @override
  String toString() {
    return 'Error{code: $code, massage: $massage}';
  }
}