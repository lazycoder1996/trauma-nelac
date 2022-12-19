import 'package:flutter/material.dart';
import 'package:nelac_eazy/views/loans/add_loan.dart';

class LoanScreen extends StatefulWidget {
  const LoanScreen({super.key});

  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
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
      // body: Padding(
      //   padding: const EdgeInsets.all(15.0),
      //   child: ListView(
      //     children: List.generate(3, (index) => LoanCard(loan: loan)),
      //   ),
      // ),
    );
  }
}
