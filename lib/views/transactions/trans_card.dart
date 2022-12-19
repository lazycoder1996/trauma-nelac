import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nelac_eazy/data/body/transaction_body.dart';
import 'package:nelac_eazy/utils/images.dart';
import 'package:nelac_eazy/utils/styles.dart';
import 'package:nelac_eazy/views/transactions/edit_transaction.dart';
import 'package:nelac_eazy/widgets/sizedbox.dart';

class TransactionCard extends StatelessWidget {
  final TransactionBody transaction;

  const TransactionCard({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (d) {
        if (transaction.paid == 0 || transaction.receiver!.isEmpty) {
          showDialog(
            context: context,
            builder: (context) => EditTransaction(
              transaction: transaction,
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
                    transaction.type!,
                    style: TextStyle(
                      color: transaction.type?.toLowerCase() == 'cash in'
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
                        transaction.sender!,
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
                        transaction.receiver!,
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
                    'GH¢ ${transaction.amount!.toStringAsFixed(2)}',
                    style: blackBold(),
                  ),
                  h(8),
                  SvgPicture.asset(
                    transaction.paid == 1 ? Images.paid : Images.pending,
                    height: 30,
                    width: 30,
                  ),
                  h(10),
                  Text(
                    transaction.date!,
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
