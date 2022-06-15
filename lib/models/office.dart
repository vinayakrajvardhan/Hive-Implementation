import 'package:hive/hive.dart';


part 'office.g.dart';
@HiveType(typeId: 3)
class Office extends HiveObject {
  @HiveField(0, defaultValue: 0)
  final int id;
  @HiveField(1)
  final int employee;
  @HiveField(2)
  final String designation;
  @HiveField(3)
  final String department;

  Office({
    required this.id,
    required this.employee,
    required this.designation,
    required this.department,
  });
}
