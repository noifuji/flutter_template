import 'package:flutter_template/domain/entity/click_count.dart';
import 'package:intl/intl.dart';

final _dateFormatter = DateFormat('y/M/d HH:mm:s.S');

class ClickCountEntity {
  ClickCountEntity(this.value, this.updateDate);
  int value;
  String updateDate;
}

ClickCountEntity modelToData(ClickCount count) {
  return ClickCountEntity(count.value, _dateFormatter.format(count.updateDate));
}

ClickCount dataToModel(ClickCountEntity count) {
  return ClickCount(
      value: count.value,
      updateDate: _dateFormatter.parseStrict(count.updateDate));
}
