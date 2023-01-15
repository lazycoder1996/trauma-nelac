import 'package:flutter/material.dart';
import 'package:nelac_eazy/data/body/earning_body.dart';
import 'package:nelac_eazy/utils/styles.dart';
import 'package:nelac_eazy/widgets/sizedbox.dart';

class EarningCard extends StatelessWidget {
  final EarningBody earning;
  const EarningCard({
    Key? key,
    required this.earning,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              earning.date!,
            ),
            h(10),
            Row(
              children: [
                const Text(
                  'Amt. Received',
                ),
                const Spacer(),
                Text(
                  'GH¢ ${earning.total!.toStringAsFixed(2)}',
                  style: blackBold(14),
                )
              ],
            ),
            h(10),
            Row(
              children: [
                const Text(
                  'Earnings',
                ),
                const Spacer(),
                Text(
                  'GH¢ ${earning.charges!.toStringAsFixed(2)}',
                  style: blackBold(14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
