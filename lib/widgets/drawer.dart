import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nelac_eazy/main.dart';
import 'package:nelac_eazy/utils/constants.dart';
import 'package:nelac_eazy/utils/images.dart';
import 'package:nelac_eazy/utils/navigation.dart';
import 'package:nelac_eazy/utils/styles.dart';
import 'package:nelac_eazy/views/earnings/earnings.dart';
import 'package:nelac_eazy/views/loans/loan_screen.dart';
import 'package:nelac_eazy/views/management/management.dart';
import 'package:nelac_eazy/views/transactions/transaction.dart';
import 'package:nelac_eazy/widgets/button.dart';
import 'package:nelac_eazy/widgets/sizedbox.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            leadingIcon: Images.management,
            onTap: () {
              toScreen(context, const ManagementScreen());
            },
            title: 'Management',
          ),
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
          DrawerItem(
            leadingIcon: Images.reset,
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: const Text('Clear Data'),
                      content: const Text(
                        'Are you sure you want to clear data? Data lost cannot be retrieved',
                        style: TextStyle(letterSpacing: 1.2),
                      ),
                      actions: [
                        CustomButton(
                          buttonText: 'Cancel',
                          bgColor: Colors.grey.shade300,
                          fgColor: Colors.black,
                          onPressed: () {
                            pop(context);
                          },
                        ),
                        CustomButton(
                          bgColor: Colors.black,
                          fgColor: Colors.white,
                          buttonText: 'Proceed',
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            for (String data in AppConstants.clearData) {
                              try {
                                await db.delete(data);
                              } catch (e) {
                                print(e.toString());
                              }
                              await prefs.remove(data);
                            }
                            Restart.restartApp();
                          },
                        ),
                      ],
                    );
                  });
            },
            title: 'Reset',
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
