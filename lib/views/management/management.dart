import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nelac_eazy/controllers/management_controller.dart';
import 'package:nelac_eazy/data/body/managment_body.dart';
import 'package:nelac_eazy/views/management/add_management.dart';
import 'package:nelac_eazy/views/management/management_card.dart';

import '../../utils/styles.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({Key? key}) : super(key: key);

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  @override
  void initState() {
    super.initState();
    // init();
  }

  init() async {
    await Get.find<ManagementController>().getManagements();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const AddManagement(),
            );
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        appBar: AppBar(
          title: const Text('Management'),
        ),
        body: GetBuilder<ManagementController>(
          builder: (mController) {
            return mController.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : mController.managements!.isEmpty
                    ? Center(
                        child: Text(
                          'No Activity',
                          style: blackBold(16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: mController.managements!.length,
                        itemBuilder: (context, index) {
                          ManagementBody mngt = mController.managements![index];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                            child: ManagementCard(mngt: mngt),
                          );
                        },
                      );
          },
        ),
      ),
    );
  }
}
