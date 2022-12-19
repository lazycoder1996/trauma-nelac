import 'package:get/get.dart';
import 'package:nelac_eazy/data/body/managment_body.dart';

import '../main.dart';
import '../utils/constants.dart';

class ManagementController extends GetxController implements GetxService {
  double _pCash = prefs.getDouble(AppConstants.pCash) ?? 0;

  double get pCash => _pCash;
  double _eCash = prefs.getDouble(AppConstants.eCash) ?? 0;

  double get eCash => _eCash;

  Future<void> updateECash(
    double amount,
    bool add,
  ) async {
    if (add) {
      amount += _eCash;
    } else {
      amount = _eCash - amount;
    }
    await prefs.setDouble(AppConstants.eCash, amount);
    _eCash = prefs.getDouble(AppConstants.eCash) ?? 0;

    update();
  }

  Future<void> updatePCash(
    double amount,
    bool add,
  ) async {
    if (add) {
      amount += _pCash;
    } else {
      amount = _pCash - amount;
    }
    await prefs.setDouble(AppConstants.pCash, amount);
    _pCash = prefs.getDouble(AppConstants.pCash) ?? 0;
    update();
  }

  int _received = prefs.getInt(AppConstants.received) ?? 0;

  int get received => _received;

  int _cashOut = prefs.getInt(AppConstants.cashOut) ?? 0;

  int get cashOut => _cashOut;

  updateReceived() async {
    await prefs.setInt(AppConstants.received, _received++);
    update();
  }

  updateCashOut() async {
    await prefs.setInt(AppConstants.cashOut, _cashOut++);
    update();
  }

  Future<void> insertManagement(ManagementBody management) async {
    await db.insert(AppConstants.management, management.toJson());
  }

  List<ManagementBody>? _managements;

  List<ManagementBody>? get managements => _managements;
  bool _loading = false;

  bool get loading => _loading;

  Future<void> getManagements() async {
    _loading = true;
    update();
    List<Map> rows = await db.query(AppConstants.management);

    print(rows);
    _managements = List.generate(rows.length,
        (index) => ManagementBody.fromMap(rows.reversed.toList()[index]));
    _loading = false;
    update();
  }
}
