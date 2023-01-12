import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nelac_eazy/controllers/management_controller.dart';
import 'package:nelac_eazy/utils/constants.dart';
import 'package:nelac_eazy/utils/styles.dart';
import 'package:nelac_eazy/views/home/cards.dart';
import 'package:nelac_eazy/widgets/drawer.dart';
import 'package:nelac_eazy/widgets/sizedbox.dart';

import '../../main.dart';
import '../transactions/add_trans.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Get.find<ManagementController>().getManagements();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const AddTransaction(),
            );
          },
        ),
        drawer: const CustomDrawer(),
        appBar: AppBar(
          title: const Text('TRAUMA NELAC EAZY'),
        ),
        body: GetBuilder<ManagementController>(builder: (mController) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMEEEEd().format(
                    DateTime.now(),
                  ),
                  style: blackBold(16),
                ),
                h(15),
                Expanded(
                  child: GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 3.0,
                      mainAxisExtent: 130,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 3.0,
                    ),
                    children: [
                      HomeCards(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'E-Cash',
                              style: blackBold(16),
                            ),
                            Text(
                              'GH¢ ${mController.eCash.toStringAsFixed(2)}',
                              style: blackBold(18, Colors.green),
                            ),
                          ],
                        ),
                      ),
                      HomeCards(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Current Bal.',
                              style: blackBold(16),
                            ),
                            Text(
                              'GH¢ ${mController.pCash.toStringAsFixed(2)}',
                              style: blackBold(
                                18,
                                parseColor(
                                    prefs.getDouble(AppConstants.eCash) ?? 0.00,
                                    prefs.getDouble(AppConstants.pCash) ??
                                        0.00),
                              ),
                            ),
                          ],
                        ),
                      ),
                      HomeCards(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Received',
                              style: blackBold(16),
                            ),
                            Text(
                              '${mController.received}',
                              style: blackBold(18, Colors.green),
                            ),
                          ],
                        ),
                      ),
                      HomeCards(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Cash Out',
                              style: blackBold(16),
                            ),
                            Text(
                              '${mController.cashOut}',
                              style: blackBold(18, Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Color parseColor(double total, double remaining) {
    if (remaining < total / 3) {
      return Colors.red;
    } else if (remaining > total / 3 && remaining < (2 * total) / 3) {
      return Colors.amber;
    }
    return Colors.green;
  }
}
