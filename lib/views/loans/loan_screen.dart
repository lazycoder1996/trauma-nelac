import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nelac_eazy/controllers/loan_controller.dart';
import 'package:nelac_eazy/data/body/loan_body.dart';
import 'package:nelac_eazy/views/loans/add_loan.dart';

import '../../utils/styles.dart';
import 'loan_card.dart';

class LoanScreen extends StatefulWidget {
  const LoanScreen({super.key});

  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Get.find<LoanController>().getLoans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context, builder: (context) => const AddLoanDialog());
        },
      ),
      appBar: AppBar(
        title: const Text('Loans'),
      ),
      body: GetBuilder<LoanController>(
        builder: (lController) {
          return lController.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : lController.loans!.isEmpty
                  ? Center(
                      child: Text(
                        'No Loans',
                        style: blackBold(16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: lController.loans!.length,
                      itemBuilder: (context, index) {
                        LoanBody loan = lController.loans![index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          child: LoanCard(loan: loan),
                        );
                      },
                    );
        },
      ),
    );
  }
}
