import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nelac_eazy/controllers/management_controller.dart';
import 'package:nelac_eazy/data/body/earning_body.dart';
import 'package:nelac_eazy/utils/convert_amount.dart';
import 'package:nelac_eazy/utils/convert_date.dart';
import 'package:nelac_eazy/utils/navigation.dart';
import 'package:nelac_eazy/widgets/button.dart';
import 'package:nelac_eazy/widgets/sizedbox.dart';
import 'package:nelac_eazy/widgets/textfield.dart';

import '../../controllers/earning_controller.dart';
import '../../main.dart';
import '../../utils/constants.dart';

class CommissionDialog extends StatefulWidget {
  final DateTime date;

  const CommissionDialog({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  State<CommissionDialog> createState() => _CommissionDialogState();
}

class _CommissionDialogState extends State<CommissionDialog> {
  TextEditingController transId = TextEditingController();
  TextEditingController balance = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    balance.text = Get.find<ManagementController>().eCash.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title:
          Text('Commission for ${DateFormat().add_yMMM().format(widget.date)}'),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: transId,
                label: 'Trans id',
                keyboardType: TextInputType.number,
                maxLength: 4,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'required';
                  }
                  if (val.length < 4) {
                    return 'Invalid entry';
                  }
                  return null;
                },
              ),
              h(10),
              CustomTextField(
                controller: balance,
                label: 'Balance',
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'required';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        CustomButton(
          buttonText: 'Cancel',
          bgColor: Colors.white,
          fgColor: Colors.black,
          onPressed: () {
            pop(context);
          },
        ),
        CustomButton(
          buttonText: 'Add',
          bgColor: Colors.black,
          fgColor: Colors.white,
          onPressed: convert(text: balance) < 100
              ? null
              : () async {
                  if (formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    double commission = calculateCommission(
                      transId: convert(text: transId),
                      balance: convert(text: balance),
                    );
                    EarningBody earning = EarningBody(
                        total: 0,
                        date: date(),
                        monthYear: DateFormat().add_yMMM().format(widget.date),
                        charges: commission);
                    await db.transaction((txn) async {
                      await txn.insert(AppConstants.earnings, earning.toJson());
                    });
                    // await Get.find<EarningController>()
                    //     .insertEarning(earning: earning);
                    //
                    await Get.find<EarningController>().getEarnings(
                        DateFormat().add_yMMM().format(widget.date));
                    if (!mounted) return;
                    pop(context);
                  }
                },
        )
      ],
    );
  }

  double calculateCommission(
      {required double transId, required double balance}) {
    return (transId - balance).toInt() / 20;
  }
}
