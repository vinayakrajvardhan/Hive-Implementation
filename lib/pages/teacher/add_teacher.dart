import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/teacher.dart';

class AddTeacher extends StatefulWidget {
  const AddTeacher({Key? key}) : super(key: key);

  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  final _key = GlobalKey<FormState>();
  int id = 0;
  String? name;
  int age = 0;
  String? subject;

  late Box<Teacher> teacherBox;

  @override
  void initState() {
    teacherBox = Hive.box<Teacher>('teachers');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Teacher')),
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
          saveTeacher();
          Navigator.pop(context);
        },
        label: const Text('Save'),
        icon: const Icon(Icons.save),
      ),
    );
  }

  void saveTeacher() {
    final _isValid = _key.currentState?.validate();
    if (_isValid != null && _isValid) {
      _key.currentState?.save();
      teacherBox.add(
        Teacher(
          id: id,
          name: name ?? "",
          age: age,
          subject: subject ?? "",
        ),
      );
    }
  }
}
