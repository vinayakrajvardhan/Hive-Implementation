import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/bank.dart';
import 'add_bank.dart';

class BankScreen extends StatefulWidget {
  const BankScreen({Key? key}) : super(key: key);

  @override
  State<BankScreen> createState() => _BankScreenState();
}

class _BankScreenState extends State<BankScreen> {
  late Box<Bank> bankBox;

  @override
  void initState() {
    super.initState();
    bankBox = Hive.box('banks');
  }

  @override
  void dispose() {
    //bankBox.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: bankBox.listenable(),
          builder: (context, box, child) {
            final filterBox = bankBox.values
                .where(
                  (element) => element.amount > 100,
                )
                .toList();
            return ListView.builder(
              itemCount: filterBox.length,
              itemBuilder: ((context, index) {
                //final bank = bankBox.getAt(index) as Bank;

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(filterBox[index].id.toString()),
                        Text(filterBox[index].name.toString()),
                        Text(filterBox[index].accountNumber.toString()),
                        Text(filterBox[index].amount.toString()),
                      ],
                    ),
                  ),
                );
              }),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AddBankScreen(),
              ));
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
