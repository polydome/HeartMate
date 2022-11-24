import 'package:freezed_annotation/freezed_annotation.dart';

part 'today_dosage_state.freezed.dart';

@freezed
class TodayDosageState with _$TodayDosageState {
  const factory TodayDosageState(
      {required bool taken,
      required double potency,
      required bool custom,
      required bool scheduleUndefined}) = _TodayDosageState;
}
