import 'package:get/get.dart';
import 'package:nelac_eazy/controllers/earning_controller.dart';
import 'package:nelac_eazy/data/body/earning_body.dart';
import 'package:nelac_eazy/utils/constants.dart';

import '../data/body/transaction_body.dart';
import '../main.dart';
import '../utils/convert_date.dart';

class TransactionController extends GetxController implements GetxService {
  List<TransactionBody>? _transactions;

  List<TransactionBody>? get transactions => _transactions;

  bool _loading = false;

  bool get loading => _loading;

  Future<void> getTransactions([String? date]) async {
    _loading = true;
    update();
    List<Map> rows = await db.query(
      AppConstants.transactions,
      whereArgs: date == null ? [] : [date],
      where: date == null ? null : 'month_year = ?',
    );
    _transactions = List.generate(rows.length,
        (index) => TransactionBody.fromMap(rows.reversed.toList()[index]));
    _loading = false;
    update();
  }

  Future<void> insertTransaction(TransactionBody transaction) async {
    await db.transaction((txn) async {
      txn.insert(AppConstants.transactions, transaction.toJson());
      List<Map> list = await txn
          .query(AppConstants.earnings, where: 'date = ?', whereArgs: [date()]);
      if (list.isEmpty) {
        await Get.find<EarningController>().insertEarning(
          txn: txn,
          earning: EarningBody(
            total: transaction.amount,
            date: transaction.date!,
            charges: transaction.charges,
            monthYear: transaction.monthYear,
          ),
        );
      } else {
        await Get.find<EarningController>().updateEarning(
          txn,
          list.first['total'] + transaction.amount,
          list.first['charges'] + transaction.charges,
          transaction.date!,
        );
      }
    });
  }

  Future<void> updateTransaction(Map<String, dynamic> values, int id) async {
    await db.update(
      AppConstants.transactions,
      values,
      where: 'id = ?',
      whereArgs: [id],
    );
    await getTransactions();
  }
}
