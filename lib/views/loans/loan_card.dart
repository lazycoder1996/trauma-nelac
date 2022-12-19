import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:nelac_eazy/controllers/loan_controller.dart';
import 'package:nelac_eazy/data/body/loan_body.dart';
import 'package:nelac_eazy/utils/images.dart';
import 'package:nelac_eazy/utils/styles.dart';

import '../../widgets/sizedbox.dart';

class LoanCard extends StatelessWidget {
  final LoanBody loan;

  const LoanCard({
    super.key,
    required this.loan,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () async {
        await Get.find<LoanController>()
            .updateLoan({'paid': 1}, loan.id!).then((value) {
          Fluttertoast.showToast(msg: 'Updated');
        });
      },
      child: Card(
        elevation: 2.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loan.date!,
                  ),
                  h(10),
                  Text(
                    loan.lender!,
                    style: blackBold(13.5),
                  ),
                  h(10),
                  Text(
                    'GH¢ ${loan.amount!.toStringAsFixed(2)}',
                    style: blackBold(14.5),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    loan.paid == 1 ? Images.paid : Images.pending,
                    height: 30,
                    width: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
