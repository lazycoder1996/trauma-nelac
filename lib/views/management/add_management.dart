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
  ];
  String value = 'Add Physical Cash';
  TextEditingController amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManagementController>(builder: (mController) {
      return AlertDialog(
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
              FocusScope.of(context).unfocus();
              await mController.insertManagement(
                ManagementBody(
                  amount: convert(text: amount),
                  date: date(),
                  type: value,
                ),
              );
              if (value == actions[0]) {
                await mController.updateECash(convert(text: amount), false);
              } else if (value == actions[1]) {
                await mController.updatePCash(convert(text: amount), true);
              }
              await mController.getManagements();
              Fluttertoast.showToast(msg: 'Added');
              pop(context);
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
    });
  }
}
