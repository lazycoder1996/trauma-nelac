import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import 'package:nelac_eazy/utils/styles.dart';
import 'package:nelac_eazy/views/transactions/trans_card.dart';

import '../../controllers/transaction_controller.dart';
import '../../data/body/transaction_body.dart';
import '../../widgets/button.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  DateTime? selectedDate;

  Future<void> init() async {
    await Get.find<TransactionController>().getTransactions(
      DateFormat().add_yMMM().format(selectedDate ?? DateTime.now()),
    );
  }

  bool showingAll = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Transactions'),
          actions: [
            IconButton(
              onPressed: () async {
                setState(() {
                  showingAll = !showingAll;
                });
                await Get.find<TransactionController>().getTransactions(
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
        body: GetBuilder<TransactionController>(
          builder: (tController) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
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
                              await Get.find<TransactionController>()
                                  .getTransactions(
                                DateFormat().add_yMMM().format(selectedDate!),
                              );
                            }
                          });
                        },
                      ),
                    const SizedBox(
                      height: 15,
                    ),
                    tController.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : tController.transactions!.isEmpty
                            ? Center(
                                child: Text(
                                  'No Transactions',
                                  style: blackBold(16),
                                ),
                              )
                            : LimitedBox(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: tController.transactions!.length,
                                  itemBuilder: (context, index) {
                                    TransactionBody transaction =
                                        tController.transactions![index];
                                    return TransactionCard(
                                        transaction: transaction);
                                  },
                                ),
                              ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
