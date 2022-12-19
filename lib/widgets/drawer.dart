import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nelac_eazy/utils/images.dart';
import 'package:nelac_eazy/utils/navigation.dart';
import 'package:nelac_eazy/utils/styles.dart';
import 'package:nelac_eazy/views/earnings/earnings.dart';
import 'package:nelac_eazy/views/loans/loan_screen.dart';
import 'package:nelac_eazy/views/transactions/transaction.dart';
import 'package:nelac_eazy/widgets/sizedbox.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Material(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                Images.logo,
                height: 150,
              ),
            ),
          ),
          h(20),
          DrawerItem(
            leadingIcon: Images.transactions,
            onTap: () {
              toScreen(context, const TransactionScreen());
            },
            title: 'Transactions',
          ),
          DrawerItem(
            leadingIcon: Images.earnings,
            onTap: () {
              toScreen(context, const Earnings());
            },
            title: 'Earnings',
          ),
          DrawerItem(
            leadingIcon: Images.loans,
            onTap: () {
              toScreen(context, const LoanScreen());
            },
            title: 'Loans',
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String leadingIcon;
  final String title;
  final void Function()? onTap;
  const DrawerItem({
    super.key,
    required this.leadingIcon,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(leadingIcon),
      title: Text(
        title,
        style: blackBold(18),
      ),
      onTap: () {
        pop(context);
        onTap!();
      },
    );
  }
}
