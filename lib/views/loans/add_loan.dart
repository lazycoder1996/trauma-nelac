import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nelac_eazy/controllers/loan_controller.dart';
import 'package:nelac_eazy/controllers/management_controller.dart';
import 'package:nelac_eazy/data/body/loan_body.dart';
import 'package:nelac_eazy/utils/convert_amount.dart';
import 'package:nelac_eazy/utils/convert_date.dart';
import 'package:nelac_eazy/widgets/sizedbox.dart';
import 'package:nelac_eazy/widgets/textfield.dart';

import '../../utils/navigation.dart';
import '../../widgets/button.dart';

class AddLoanDialog extends StatefulWidget {
  const AddLoanDialog({super.key});

  @override
  State<AddLoanDialog> createState() => _AddLoanDialogState();
}

class _AddLoanDialogState extends State<AddLoanDialog> {
  TextEditingController lender = TextEditingController();
  TextEditingController amount = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AlertDialog(
        actions: [
          CustomButton(
            buttonText: 'Cancel',
            bgColor: Colors.grey.shade300,
            fgColor: Colors.black,
            onPressed: () {
              pop(context);
            },
          ),
          CustomButton(
            buttonText: 'Save',
            bgColor: Colors.black,
            fgColor: Colors.white,
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                await Get.find<LoanController>()
                    .insertLoan(
                  LoanBody(
                      paid: 0,
                      date: date(),
                      amount: convert(text: amount),
                      lender: lender.text.trim()),
                )
                    .then((value) async {
                  await Get.find<ManagementController>()
                      .updatePCash(convert(text: amount), true);

                  Fluttertoast.showToast(msg: 'Added');
                  pop(context);
                });
              }
            },
          ),
        ],
        backgroundColor: Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Center(child: Text('Add Loan Entry')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: lender,
              label: 'Name',
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            h(10),
            CustomTextField(
              controller: amount,
              label: 'Amount',
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
