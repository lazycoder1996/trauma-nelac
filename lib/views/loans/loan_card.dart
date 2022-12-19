// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:nelac_eazy/data/models/loan_model.dart';
// import 'package:nelac_eazy/utils/images.dart';
// import 'package:nelac_eazy/utils/styles.dart';
//
// import '../../widgets/sizedbox.dart';
//
// class LoanCard extends StatelessWidget {
//   final LoanModel loan;
//   const LoanCard({
//     super.key,
//     required this.loan,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2.5,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(loan.date!, style: blackBold(14)),
//                 h(8),
//                 Text(
//                   loan.lender!,
//                   style: blackBold(14),
//                 ),
//                 h(8),
//                 Text(
//                   'GH¢ ${loan.amount!.toStringAsFixed(2)}',
//                   style: blackBold(14),
//                 ),
//               ],
//             ),
//             const Spacer(),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 SvgPicture.asset(
//                   loan.paid! ? Images.paid : Images.pending,
//                   height: 30,
//                   width: 30,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
