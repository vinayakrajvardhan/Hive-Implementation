import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_implementation/models/office.dart';

class AddOffice extends StatefulWidget {
  const AddOffice({Key? key}) : super(key: key);

  @override
  State<AddOffice> createState() => _AddOfficeState();
}

class _AddOfficeState extends State<AddOffice> {
  final _key = GlobalKey<FormState>();
  int id = 0;
  int employee = 0;
  String? designation;
  String? department;
  late Box<Office> officeBox;

  @override
  void initState() {
    officeBox = Hive.box<Office>("officeDart");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Form(
                key: _key,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Id', helperText: 'Input your id'),
                      onSaved: (value) {
                        setState(() {
                          id = int.parse(value.toString());
                        });
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          labelText: 'Designation',
                          helperText: 'Input your designation'),
                      onSaved: (value) {
                        designation = value;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Employee',
                          helperText: 'Input your number of employee'),
                      onSaved: (value) {
                        employee = int.parse(value.toString());
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Department',
                          helperText: 'Input your department'),
                      onSaved: (value) {
                        department = value.toString();
                      },
                    ),
                  ],
                ),
              ),
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
      ),
    );
  }

  void saveOffice() {
    final _isValid = _key.currentState?.validate();
    if (_isValid != null && _isValid) {
      _key.currentState?.save();
      officeBox.add(
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
