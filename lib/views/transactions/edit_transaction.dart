import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nelac_eazy/controllers/transaction_controller.dart';
import 'package:nelac_eazy/data/body/transaction_body.dart';
import 'package:nelac_eazy/utils/navigation.dart';
import 'package:nelac_eazy/widgets/button.dart';
import 'package:nelac_eazy/widgets/textfield.dart';

class EditTransaction extends StatefulWidget {
  final TransactionBody transaction;

  const EditTransaction({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  TextEditingController receiver = TextEditingController();
  bool paid = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: const Center(child: Text('Edit Transaction')),
      actions: [
        CustomButton(
          buttonText: 'Cancel',
          onPressed: () {
            pop(context);
          },
          bgColor: Colors.grey.shade300,
          fgColor: Colors.black,
        ),
        CustomButton(
          buttonText: 'Save',
          bgColor: Colors.black,
          onPressed: () async {
            if (paid || receiver.text.isNotEmpty) {
              FocusScope.of(context).unfocus();
              Map<String, dynamic> values = {};
              if (paid) {
                values['paid'] = 1;
              }
              if (receiver.text.isNotEmpty) {
                values['receiver'] = receiver.text.trim();
              }
              await Get.find<TransactionController>()
                  .updateTransaction(values, widget.transaction.id!)
                  .then((value) {
                Fluttertoast.showToast(msg: 'Updated');
                pop(context);
              });
            } else {
              pop(context);
            }
          },
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.transaction.receiver!.isEmpty)
            CustomTextField(
              controller: receiver,
              label: 'Receiver',
            ),
          if (widget.transaction.paid == 0)
            SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                activeColor: Colors.black,
                title: const Text('Paid out?'),
                value: paid,
                onChanged: (v) {
                  setState(() {
                    paid = v;
                  });
                }),
        ],
      ),
    );
  }
}
