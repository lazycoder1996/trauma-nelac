import 'package:get/get.dart';
import 'package:nelac_eazy/data/body/earning_body.dart';
import 'package:nelac_eazy/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

import '../main.dart';

class EarningController extends GetxController implements GetxService {
  List<EarningBody>? _earnings;

  List<EarningBody>? get earnings => _earnings;

  bool _loading = false;

  bool get loading => _loading;

  Future<void> getEarnings([String? date]) async {
    _loading = true;
    update();
    List<Map> rows = await db.query(
      AppConstants.earnings,
      whereArgs: date == null ? [] : [date],
      where: date == null ? null : 'month_year = ?',
    );
    _earnings = List.generate(rows.length,
        (index) => EarningBody.fromMap(rows.reversed.toList()[index]));
    _loading = false;
    update();
  }

  Future<void> insertEarning(Transaction txn, EarningBody earning) async {
    // await db.transaction((txn) async {
    await txn.insert(AppConstants.earnings, earning.toJson());
    // });
  }

  Future<void> updateEarning(
      Transaction txn, double total, double charges, String date) async {
    // await db.transaction(
    //   (txn) async {
    await txn.update(
        AppConstants.earnings,
        {
          'total': total,
          'charges': charges,
        },
        where: 'date = ?',
        whereArgs: [date]);
    //   },
    // );
  }
}
