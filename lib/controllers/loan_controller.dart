import 'package:get/get.dart';
import 'package:nelac_eazy/data/body/loan_body.dart';

import '../main.dart';
import '../utils/constants.dart';

class LoanController extends GetxController implements GetxService {
  List<LoanBody>? _loans;

  List<LoanBody>? get loans => _loans;

  bool _loading = false;

  bool get loading => _loading;

  Future<void> getLoans() async {
    _loading = true;
    update();
    List<Map> rows = await db.query(AppConstants.loans);

    _loans = List.generate(rows.length,
        (index) => LoanBody.fromMap(rows.reversed.toList()[index]));
    _loading = false;
    update();
  }

  Future<void> insertLoan(LoanBody loan) async {
    await db.insert(AppConstants.loans, loan.toJson());
    await getLoans();
  }

  Future<void> updateLoan(Map<String, dynamic> values, int id) async {
    await db.update(
      AppConstants.loans,
      values,
      where: 'id = ?',
      whereArgs: [id],
    );
    await getLoans();
  }
}
