import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nelac_eazy/utils/styles.dart';
import 'package:nelac_eazy/views/home/add_trans.dart';
import 'package:nelac_eazy/views/home/cards.dart';
import 'package:nelac_eazy/widgets/drawer.dart';
import 'package:nelac_eazy/widgets/sizedbox.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context, builder: (context) => const AddTransaction());
          },
        ),
        drawer: const CustomDrawer(),
        appBar: AppBar(
          title: const Text('TRAUMA NELAC EAZY'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMEEEEd().format(
                  DateTime.now(),
                ),
                style: blackBold(16),
              ),
              h(15),
              Expanded(
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 3.0,
                    mainAxisExtent: 130,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 3.0,
                  ),
                  children: [
                    HomeCards(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Starting Bal.',
                            style: blackBold(16),
                          ),
                          Text(
                            'GHS 3000.00',
                            style: blackBold(18, Colors.green),
                          ),
                        ],
                      ),
                    ),
                    HomeCards(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Current Bal.',
                            style: blackBold(16),
                          ),
                          Text(
                            'GHS 120.00',
                            style: blackBold(18, Colors.red),
                          ),
                        ],
                      ),
                    ),
                    HomeCards(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Received',
                            style: blackBold(16),
                          ),
                          Text(
                            '40',
                            style: blackBold(18, Colors.green),
                          ),
                        ],
                      ),
                    ),
                    HomeCards(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Cash Out',
                            style: blackBold(16),
                          ),
                          Text(
                            '3',
                            style: blackBold(18, Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
