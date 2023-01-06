import 'package:apkainzynierka/feature/today_dosage/model/state.dart';
import 'package:apkainzynierka/feature/today_dosage/service/cubit.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart' hide Router;

class TodayDosageView extends StatelessWidget {
  final TodayDosageState state;
  final TodayDosageCubit cubit;

  const TodayDosageView({super.key, required this.state, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DottedBorder(
          color: borderColor,
          borderPadding: const EdgeInsets.all(2),
          strokeCap: StrokeCap.round,
          borderType: BorderType.RRect,
          radius: const Radius.circular(6),
          dashPattern: const [6, 10],
          strokeWidth: state.taken ? 0 : 3,
          child: SizedBox.expand(
            child: Stack(
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: backgroundColor, elevation: 0),
                    onLongPress: () => cubit.showCustomDosageScreen(),
                    onPressed: () => cubit.toggleTaken(),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Dzisiejsza dawka"),
                          const SizedBox(height: 10),
                          Text(
                            hintText,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Icon(
                      Icons.medication,
                      size: 36,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String get hintText {
    if (state.scheduleUndefined) {
      return "Brak harmonogramu!";
    }

    if (state.taken) {
      return "Przyjęto dawkę ${state.potency}";
    } else {
      return "Przyjmij dawkę ${state.potency}";
    }
  }

  Color get backgroundColor {
    if (state.scheduleUndefined) {
      return const Color(0xffAD6902);
    }

    if (state.taken) {
      return Colors.green;
    }

    return Colors.transparent;
  }

  Color get borderColor {
    if (!state.taken && !state.scheduleUndefined) {
      return Colors.white;
    }

    return Colors.transparent;
  }
}
