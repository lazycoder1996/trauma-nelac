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
              style: blackBold(15),
            ),
            h(5),
            Row(
              children: [
                Text(
                  'Amt. Received',
                  style: blackBold(14),
                ),
                const Spacer(),
                Text('GH¢ ${earning.total!.toStringAsFixed(2)}')
              ],
            ),
            h(10),
            Row(
              children: [
                Text(
                  'Earnings',
                  style: blackBold(14),
                ),
                const Spacer(),
                Text('GH¢ ${earning.charges!.toStringAsFixed(2)}')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
