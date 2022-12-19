import 'package:get/get.dart';
import 'package:nelac_eazy/controllers/earning_controller.dart';
import 'package:nelac_eazy/controllers/loan_controller.dart';
import 'package:nelac_eazy/controllers/management_controller.dart';
import 'package:nelac_eazy/controllers/transaction_controller.dart';

Future<void> init() async {
  Get.lazyPut(() => TransactionController());
  Get.lazyPut(() => EarningController());
  Get.lazyPut(() => LoanController());
  Get.lazyPut(() => ManagementController());
}
