import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nelac_eazy/utils/styles.dart';
import 'package:nelac_eazy/views/transactions/trans_card.dart';

import '../../controllers/transaction_controller.dart';
import '../../data/body/transaction_body.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Get.find<TransactionController>().getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: GetBuilder<TransactionController>(
        builder: (tController) {
          return tController.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : tController.transactions!.isEmpty
                  ? Center(
                      child: Text(
                        'No Transactions',
                        style: blackBold(16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: tController.transactions!.length,
                      itemBuilder: (context, index) {
                        TransactionBody transaction =
                            tController.transactions![index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          child: TransactionCard(transaction: transaction),
                        );
                      },
                    );
        },
      ),
    );
  }
}
