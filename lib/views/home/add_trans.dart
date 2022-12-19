import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nelac_eazy/controllers/transaction_controller.dart';
import 'package:nelac_eazy/data/body/transaction_body.dart';
import 'package:nelac_eazy/utils/convert_amount.dart';
import 'package:nelac_eazy/utils/convert_date.dart';
import 'package:nelac_eazy/utils/navigation.dart';
import 'package:nelac_eazy/widgets/button.dart';
import 'package:nelac_eazy/widgets/dropdown.dart';
import 'package:nelac_eazy/widgets/sizedbox.dart';
import 'package:nelac_eazy/widgets/textfield.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  TextEditingController sender = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController charges = TextEditingController();
  String type = 'Received';

  String? validator(String? val) {
    if (val!.isEmpty) {
      return 'required';
    }
    return null;
  }

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
              FocusScope.of(context).unfocus();
              await Get.find<TransactionController>()
                  .insertTransaction(
                TransactionBody(
                  amount: convert(text: amount),
                  date: date(),
                  charges: convert(text: charges),
                  paid: 0,
                  receiver: '',
                  sender: sender.text.trim(),
                  type: type,
                ),
              )
                  .then((value) {
                Fluttertoast.showToast(msg: 'Added');
                pop(context);
              });
            },
          ),
        ],
        backgroundColor: Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Center(
          child: Text(
            'ADD ENTRY',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: sender,
              label: 'Sender',
              validator: (val) => validator(val),
            ),
            h(10),
            CustomDropdown(
                value: type,
                items: const ['Received', 'Cash out'],
                label: 'Type',
                onChanged: (val) {
                  setState(() {
                    type = val!;
                  });
                }),
            h(10),
            CustomTextField(
              keyboardType: TextInputType.number,
              controller: amount,
              label: 'Amount',
              validator: (val) => validator(val),
            ),
            h(10),
            CustomTextField(
              keyboardType: TextInputType.number,
              controller: charges,
              label: 'Charges',
              validator: (val) => validator(val),
            ),
          ],
        ),
      ),
    );
  }
}
