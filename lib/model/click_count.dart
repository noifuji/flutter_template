class ClickCount {
  final int _value;
  final DateTime? _updateDate;

  ClickCount(this._value, this._updateDate);

  DateTime? get updateDate => _updateDate;
  int get value => _value;
}