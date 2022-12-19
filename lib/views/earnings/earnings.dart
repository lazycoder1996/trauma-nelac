import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import 'package:nelac_eazy/controllers/earning_controller.dart';
import 'package:nelac_eazy/data/body/earning_body.dart';
import 'package:nelac_eazy/utils/styles.dart';
import 'package:nelac_eazy/views/earnings/earnings_card.dart';
import 'package:nelac_eazy/widgets/button.dart';

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
        DateFormat().add_yMMM().format(selectedDate ?? DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earnings'),
      ),
      body: GetBuilder<EarningController>(builder: (eController) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
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
                        await Get.find<EarningController>().getEarnings(
                          DateFormat().add_yMMM().format(selectedDate!),
                        );
                      }
                    });
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                eController.loading
                    ? const CircularProgressIndicator()
                    : eController.earnings!.isEmpty
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
                              itemCount: eController.earnings!.length,
                              itemBuilder: (context, index) {
                                EarningBody earning =
                                    eController.earnings![index];
                                return EarningCard(earning: earning);
                              },
                            ),
                          ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
