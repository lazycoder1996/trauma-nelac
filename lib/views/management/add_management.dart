import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nelac_eazy/controllers/management_controller.dart';
import 'package:nelac_eazy/data/body/managment_body.dart';
import 'package:nelac_eazy/utils/convert_amount.dart';
import 'package:nelac_eazy/utils/convert_date.dart';
import 'package:nelac_eazy/widgets/sizedbox.dart';
import 'package:nelac_eazy/widgets/textfield.dart';

import '../../utils/navigation.dart';
import '../../widgets/button.dart';
import '../../widgets/dropdown.dart';

class AddManagement extends StatefulWidget {
  const AddManagement({Key? key}) : super(key: key);

  @override
  State<AddManagement> createState() => _AddManagementState();
}

class _AddManagementState extends State<AddManagement> {
  List<String> actions = [
    'Pay e-Cash',
    'Add Physical Cash',
    'Add Electronic Cash'
  ];
  String value = 'Add Physical Cash';
  TextEditingController amount = TextEditingController();
  TextEditingController merchant = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagementController>(builder: (mController) {
      return Form(
        key: formKey,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
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
                if (formKey.currentState!.validate()) {
                  FocusScope.of(context).unfocus();
                  if (value == actions[0] &&
                      convert(text: amount) > mController.eCash) {
                    Fluttertoast.showToast(msg: 'Insufficient funds');
                    return;
                  }
                  await mController.insertManagement(
                    ManagementBody(
                      amount: convert(text: amount),
                      date: date(),
                      type: value,
                      merchantName: merchant.text.trim(),
                    ),
                  );
                  if (value == actions[0]) {
                    await mController.updateECash(convert(text: amount), false);
                  } else if (value == actions[1]) {
                    await mController.updatePCash(convert(text: amount), true);
                  } else if (value == actions[2]) {
                    await mController.updateECash(convert(text: amount), true);
                  }
                  await mController.getManagements();
                  Fluttertoast.showToast(msg: 'Added');
                  if (!mounted) return;
                  pop(context);
                }
              },
            ),
          ],
          title: const Center(child: Text('Add Record')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomDropdown(
                value: value,
                items: actions,
                label: 'Action',
                onChanged: (val) {
                  setState(() {
                    value = val!;
                  });
                },
              ),
              h(10),
              if (value == actions.first) ...[
                CustomTextField(
                  controller: merchant,
                  label: 'Merchant Name',
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
                h(10),
              ],
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
    });
  }
}
