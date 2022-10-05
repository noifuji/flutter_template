import 'package:flutter_template/data/click_count_entity.dart';
import 'package:flutter_template/model/click_count.dart';
import 'package:intl/intl.dart';

class ClickCountMapper {
  static final _dateFormatter = DateFormat("y/M/d HH:mm:s.S");
  static ClickCountEntity modelToData(ClickCount count) {

    int value = count.value;
    String? updatedDate;

    if(count.updateDate != null) {
      updatedDate = _dateFormatter.format(count.updateDate!);
    }

    return ClickCountEntity(value, updatedDate);
  }

  static ClickCount dataToModel(ClickCountEntity count) {

    int value = count.value;
    DateTime? updatedDate;

    if(count.updateDate != null) {
      updatedDate = _dateFormatter.parseStrict(count.updateDate!);
    }

    return ClickCount(value, updatedDate);
  }

}