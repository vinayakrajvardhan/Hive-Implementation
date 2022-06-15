import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_implementation/models/office.dart';
import 'package:hive_implementation/pages/office/add_office.dart';
import 'package:hive_implementation/pages/office/edit_office.dart';

class OfficeScreen extends StatefulWidget {
  const OfficeScreen({Key? key}) : super(key: key);

  @override
  State<OfficeScreen> createState() => _OfficeScreenState();
}

class _OfficeScreenState extends State<OfficeScreen> {
  late Box<Office> officeBox;
  @override
  void initState() {
    officeBox = Hive.box<Office>("officeDart");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: officeBox.listenable(),
          builder: (context, box, child) {
            return ListView.builder(
                itemCount: officeBox.length,
                itemBuilder: (context, index) {
                  final office = officeBox.getAt(index) as Office;
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditOffice(index: index),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Text(
                            office.id.toString(),
                          ),
                          Text(
                            office.department.toString(),
                          ),
                          Text(
                            office.employee.toString(),
                          ),
                          Text(
                            office.designation.toString(),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddOffice()));
        },
        label: const Text('Add'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
