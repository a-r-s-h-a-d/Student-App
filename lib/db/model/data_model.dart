import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 0) //This is model class Type ID
class StudentModel extends HiveObject{
  @HiveField(0)
  final int? id;
  @HiveField(1) //This is field index
  final String name;
  @HiveField(2) //This is field index
  final String age;
  @HiveField(3) //This is field index
  final String email;
  @HiveField(4) //This is field index
  final String contacts;
  @HiveField(5)
  final String image;

  StudentModel(
      {required this.name,
      required this.age,
      required this.email,
      required this.contacts,
      required this.image,
      this.id});
}
