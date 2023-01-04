import 'package:apkainzynierka/feature/last_inr_measurements/last_inr_measurements.dart';
import 'package:apkainzynierka/feature/report_inr/report_inr.dart';
import 'package:apkainzynierka/main.dart';
import 'package:apkainzynierka/today_dosage/state/today_dosage_state.dart';
import 'package:apkainzynierka/today_dosage/today_dosage_cubit.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TodayDosageView extends StatelessWidget {
  final TodayDosageState state;
  final TodayDosageCubit cubit;

  const TodayDosageView({super.key, required this.state, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TodayDosageCubit>();
    const state = TodayDosageState(
        taken: true, potency: 2, custom: false, scheduleUndefined: true);
    //const state = widget.state;
    return Column(
      children: [
        SizedBox(
          height: 90,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DottedBorder(
              color: state.taken ? Colors.transparent : Colors.white,
              strokeCap: StrokeCap.round,
              dashPattern: const [8, 8],
              strokeWidth: state.taken ? 0 : 4,
              child: SizedBox.expand(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: getBackgroundColor(), elevation: 0),
                    onLongPress: () => cubit.showCustomDosageScreen(),
                    onPressed: () => cubit.toggleTaken(),
                    child: Text(
                      "Dzisiejsza dawka\n\n"
                      " ${state.taken ? "Przyjęto dawkę" : "Przyjmij dawkę"}"
                      " ${state.potency}"
                      " mg",
                      // style: const TextStyle(
                      //   fontSize: 16.0,
                      //   fontStyle: FontStyle.italic,
                      // ),
                      textAlign: TextAlign.center,
                    )),
              ),
            ),
          ),
        ),
        SizedBox(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                  7,
                  (index) => Column(children: const [
                        Text("Pn"),
                        SizedBox(
                          height: 5,
                        ),
                        DailyDosageCircle()
                      ]))),
        )),
        SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox.expand(
                child: ElevatedButton(
                    onPressed: () => context.push('/schedules/current'),
                    child: const Text("Dostosuj harmonogram"))),
          ),
        ),
        const SizedBox(height: 150, child: LastInrMeasurements()),
        SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox.expand(
                child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext _) {
                          return Provider<AppContainer>.value(
                              value: context.read(),
                              builder: (context, child) =>
                                  const ReportInrDialog());
                        },
                      );
                    },
                    child: const Text("Dodaj pomiar INR"))),
          ),
        ),
      ],
    );
  }

  Color getBackgroundColor() {
    if (state.scheduleUndefined) {
      return Colors.amber;
    }

    if (state.taken) {
      return Colors.green;
    }
    return Colors.transparent;
  }
}

class DailyDosageCircle extends StatelessWidget {
  const DailyDosageCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 50,
      width: 50,
      child: Material(
        shape: CircleBorder(
            side: BorderSide(
          color: Colors.green,
          width: 2,
        )),
        child: Center(child: Text('1.5')),
      ),
    );
  }
}
