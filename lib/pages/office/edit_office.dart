import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';

import '../../models/office.dart';

class EditOffice extends StatefulWidget {
  final int index;
  const EditOffice({Key? key, required this.index}) : super(key: key);

  @override
  State<EditOffice> createState() => _EditOfficeState();
}

class _EditOfficeState extends State<EditOffice> {
  final _key = GlobalKey<FormState>();
  int id = 0;
  int employee = 0;
  String? designation;
  String? department;
  late TextEditingController _idController;
  late TextEditingController _employeeController;
  late TextEditingController _departmentController;
  late TextEditingController _designationController;
  late Box<Office> officeBox;

  @override
  void initState() {
    officeBox = Hive.box<Office>("officeDart");
    _idController = TextEditingController();
    _employeeController = TextEditingController();
    _departmentController = TextEditingController();
    _designationController = TextEditingController();

    final office = officeBox.getAt(widget.index) as Office;
    _idController.text = office.id.toString();
    _employeeController.text = office.employee.toString();
    _departmentController.text = office.department.toString();
    _designationController.text = office.designation.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Teacher'),
        actions: [
          IconButton(
            onPressed: () {
              deleteOffice();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Form(
                key: _key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _idController,
                      keyboardType: TextInputType.number,
                      enabled: false,
                      decoration: const InputDecoration(
                          labelText: 'Id', helperText: 'Input your id'),
                      onSaved: (value) {
                        id = int.parse(value.toString());
                      },
                    ),
                    TextFormField(
                      controller: _departmentController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          labelText: 'Department',
                          helperText: 'Input your department'),
                      onSaved: (value) {
                        department = value.toString();
                      },
                    ),
                    TextFormField(
                      controller: _employeeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Employee',
                          helperText: 'Input your number of employee'),
                      onSaved: (value) {
                        employee = int.parse(value.toString());
                      },
                    ),
                    TextFormField(
                      controller: _designationController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Designation',
                          helperText: 'Input your designation'),
                      onSaved: (value) {
                        designation = value.toString();
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          saveOffice();
          Navigator.pop(context);
        },
        label: const Text('Save'),
        icon: const Icon(Icons.save),
      ),
    );
  }

  void deleteOffice() async {
    await officeBox.deleteAt(widget.index);
  }

  void saveOffice() async {
    final isValid = _key.currentState?.validate();

    if (isValid != null && isValid) {
      _key.currentState?.save();
      await officeBox.putAt(
        widget.index,
        Office(
          id: id,
          employee: employee,
          designation: designation ?? "",
          department: department ?? "",
        ),
      );
    }
  }
}
