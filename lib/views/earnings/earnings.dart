import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import 'package:nelac_eazy/controllers/earning_controller.dart';
import 'package:nelac_eazy/data/body/earning_body.dart';
import 'package:nelac_eazy/utils/images.dart';
import 'package:nelac_eazy/utils/styles.dart';
import 'package:nelac_eazy/views/earnings/earnings_card.dart';
import 'package:nelac_eazy/widgets/button.dart';

import 'commission_dialog.dart';

class Earnings extends StatefulWidget {
  const Earnings({super.key});

  @override
  State<Earnings> createState() => _EarningsState();
}

DateTime? selectedDate;

class _EarningsState extends State<Earnings> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Get.find<EarningController>().getEarnings(
      DateFormat().add_yMMM().format(selectedDate ?? DateTime.now()),
    );
  }

  double sumEarnings(List<EarningBody> earnings) {
    double sum = 0;
    for (EarningBody earning in earnings) {
      sum += earning.charges!;
    }
    return sum;
  }

  bool showingAll = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Earnings'),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => CommissionDialog(
                          date: selectedDate ?? DateTime.now(),
                        ));
              },
              icon: SvgPicture.asset(Images.commission),
            ),
            IconButton(
              onPressed: () async {
                setState(() {
                  showingAll = !showingAll;
                });

                await Get.find<EarningController>().getEarnings(
                  showingAll
                      ? null
                      : DateFormat().add_yMMM().format(selectedDate!),
                );
              },
              icon: Icon(showingAll
                  ? Icons.calendar_month_outlined
                  : Icons.view_compact_alt_outlined),
            ),
          ],
        ),
        body: GetBuilder<EarningController>(builder: (eController) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: eController.loading
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!showingAll)
                              CustomButton(
                                bgColor: Colors.black,
                                buttonText: DateFormat()
                                    .add_yMMM()
                                    .format(selectedDate ?? DateTime.now()),
                                onPressed: () {
                                  showMonthPicker(
                                    dismissible: true,
                                    context: context,
                                    initialDate: selectedDate ?? DateTime.now(),
                                    selectedMonthBackgroundColor: Colors.black,
                                    selectedMonthTextColor: Colors.white,
                                    unselectedMonthTextColor: Colors.black,
                                    headerColor: Colors.white,
                                    headerTextColor: Colors.black,
                                    roundedCornersRadius: 15,
                                    confirmText: Text(
                                      'Confirm',
                                      style: blackBold(16, Colors.black),
                                    ),
                                    cancelText: Text(
                                      'Cancel',
                                      style: blackBold(14, Colors.red),
                                    ),
                                  ).then((date) async {
                                    if (date != null) {
                                      setState(() {
                                        selectedDate = date;
                                      });
                                      await Get.find<EarningController>()
                                          .getEarnings(
                                        DateFormat()
                                            .add_yMMM()
                                            .format(selectedDate!),
                                      );
                                    }
                                  });
                                },
                              ),
                            const Spacer(),
                            Text(
                              'Earnings: GH¢ ${sumEarnings(eController.earnings!).toStringAsFixed(2)}',
                              style: blackBold(15),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        eController.earnings!.isEmpty
                            ? Center(
                                child: Text(
                                  'No earnings for this month',
                                  style: blackBold(16),
                                ),
                              )
                            : LimitedBox(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: eController.earnings!
                                      .where((element) => element.total != 0)
                                      .toList()
                                      .length,
                                  itemBuilder: (context, index) {
                                    EarningBody earning = eController.earnings!
                                        .where((element) => element.total != 0)
                                        .toList()[index];
                                    return EarningCard(earning: earning);
                                  },
                                ),
                              ),
                      ],
                    ),
            ),
          );
        }),
      ),
    );
  }
}
