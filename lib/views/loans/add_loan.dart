import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
            // TODO: ADD TO DB
            pop(context);
          },
        ),
      ],
      backgroundColor: Colors.grey.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: const Text('Add Loan Entry'),
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
    );
  }
}
