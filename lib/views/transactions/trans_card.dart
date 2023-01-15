import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nelac_eazy/controllers/earning_controller.dart';
import 'package:nelac_eazy/controllers/management_controller.dart';
import 'package:nelac_eazy/controllers/transaction_controller.dart';
import 'package:nelac_eazy/data/body/transaction_body.dart';
import 'package:nelac_eazy/utils/images.dart';
import 'package:nelac_eazy/utils/navigation.dart';
import 'package:nelac_eazy/utils/styles.dart';
import 'package:nelac_eazy/views/transactions/edit_transaction.dart';
import 'package:nelac_eazy/widgets/sizedbox.dart';

class TransactionCard extends StatefulWidget {
  final TransactionBody transaction;

  const TransactionCard({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showBottomSheet(
          context: context,
          builder: (context) => BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                height: 50,
                color: Colors.black,
                width: double.maxFinite,
                child: GetBuilder<ManagementController>(builder: (mController) {
                  return TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      if (widget.transaction.type?.toLowerCase() == 'cash in') {
                        // ADD TO E CASH
                        await mController.updateECash(
                            widget.transaction.amount!, true);
                        // SUBTRACT TO P CASH
                        await mController.updatePCash(
                            widget.transaction.amount!, false);
                      } else if (widget.transaction.type?.toLowerCase() ==
                          'cash out') {
                        // SUBTRACT FROM E CASH
                        await mController.updateECash(
                            widget.transaction.amount!, false);
                        // ADD TO P CASH
                        await mController.updatePCash(
                            widget.transaction.amount!, true);
                      } else if (widget.transaction.type?.toLowerCase() ==
                          'received') {
                        // SUBTRACT FROM E CASH
                        await mController.updateECash(
                            widget.transaction.amount!, false);
                        // ADD TO P CASH
                        await mController.updatePCash(
                            widget.transaction.amount!, true);
                        await mController.updatePCash(
                            widget.transaction.charges!, false);
                      }
                      await Get.find<EarningController>()
                          .delete(widget.transaction);
                      await Get.find<TransactionController>()
                          .delete(widget.transaction);
                      await Get.find<TransactionController>().getTransactions();
                      await Get.find<EarningController>().getEarnings();
                      if (!mounted) return;
                      pop(context);
                      setState(() {});
                    },
                    child: const Text(
                      'Delete Transaction',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }),
              );
            },
          ),
        );
      },
      onHorizontalDragEnd: (d) {
        if (widget.transaction.paid == 0 ||
            widget.transaction.receiver!.isEmpty) {
          showDialog(
            context: context,
            builder: (context) => EditTransaction(
              transaction: widget.transaction,
            ),
          );
        }
      },
      child: Card(
        elevation: 2.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.transaction.type!,
                    style: TextStyle(
                      color: widget.transaction.type?.toLowerCase() == 'cash in'
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                  h(8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('From: '),
                      Text(
                        widget.transaction.sender!,
                        style: blackBold(14),
                      ),
                    ],
                  ),
                  h(8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('To: '),
                      Text(
                        widget.transaction.receiver!,
                        style: blackBold(14),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'GH¢ ${widget.transaction.amount!.toStringAsFixed(2)}',
                    style: blackBold(),
                  ),
                  h(8),
                  SvgPicture.asset(
                    widget.transaction.paid == 1 ? Images.paid : Images.pending,
                    height: 30,
                    width: 30,
                  ),
                  h(10),
                  Text(
                    widget.transaction.date!,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 11,
                    ),
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
