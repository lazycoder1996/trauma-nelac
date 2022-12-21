import 'package:flutter/material.dart';
import 'package:nelac_eazy/data/body/managment_body.dart';
import 'package:nelac_eazy/utils/styles.dart';

import '../../widgets/sizedbox.dart';

class ManagementCard extends StatelessWidget {
  final ManagementBody mngt;

  const ManagementCard({
    super.key,
    required this.mngt,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  mngt.date!,
                ),
                h(10),
                Row(
                  children: [
                    Text(
                      mngt.type!,
                      style: blackBold(13.5),
                    ),
                    w(15),
                    if (mngt.merchantName!.isNotEmpty)
                      Text(
                        'To: ${mngt.merchantName!}',
                        style: blackBold(13.5),
                      ),
                  ],
                ),
                h(10),
                Text(
                  'GH¢ ${mngt.amount!.toStringAsFixed(2)}',
                  style: blackBold(14.5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
