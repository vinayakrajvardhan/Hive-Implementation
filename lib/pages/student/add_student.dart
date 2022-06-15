import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import '../../models/student.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _key = GlobalKey<FormState>();
  int id = 0;
  String? name;
  int age = 0;
  String? subject;

  late Box<Student> studenBox;
  @override
  void initState() {
    studenBox = Hive.box<Student>('students');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Student')),
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
                        labelText: 'Name', helperText: 'Input your name'),
                    onSaved: (value) {
                      name = value;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Age', helperText: 'Input your age'),
                    onSaved: (value) {
                      age = int.parse(value.toString());
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'Subject', helperText: 'Input your subject'),
                    onSaved: (value) {
                      subject = value.toString();
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
          saveStudent();
        },
        label: const Text('Save'),
        icon: const Icon(Icons.save),
      ),
    );
  }

  void saveStudent() {
    final isValid = _key.currentState?.validate();
    if (isValid != null && isValid == true) {
      _key.currentState?.save();
      studenBox.add(Student(
        id: id,
        name: name ?? "",
        age: age,
        subject: subject ?? "",
      ));
    }
  }
}
