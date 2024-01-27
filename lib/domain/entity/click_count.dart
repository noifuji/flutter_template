// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'click_count.freezed.dart';
part 'click_count.g.dart';

@freezed
class ClickCount with _$ClickCount {
  const factory ClickCount({required int value, required DateTime updateDate}) =
      _ClickCount;

  factory ClickCount.fromJson(Map<String, Object?> json) =>
      _$ClickCountFromJson(json);
}
