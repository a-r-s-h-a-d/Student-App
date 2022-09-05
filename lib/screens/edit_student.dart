import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_details/db/function/db_function.dart';
import 'package:student_details/db/model/data_model.dart';
import 'package:student_details/screens/view_students.dart';

class EditStudent extends StatefulWidget {
  EditStudent({Key? key, required this.student}) : super(key: key);
  StudentModel student;

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _nameController;
  TextEditingController? _ageController;
  TextEditingController? _emailController;
  TextEditingController? _contactController;

  String? image;

  @override
  void initState() {
    image = widget.student.image;
    _nameController = TextEditingController(text: widget.student.name);
    _ageController = TextEditingController(text: widget.student.age);
    _emailController = TextEditingController(text: widget.student.email);
    _contactController = TextEditingController(text: widget.student.contacts);
    super.initState();
  }

  Future<void> pickImage({required ImageSource source}) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      this.image = pickedImage.path;
    });
  }

  //
  Future<void> onAddStudentButtonClicked() async {
    final _name = _nameController!.text.trim();
    final _age = _ageController!.text.trim();
    final _email = _emailController!.text.trim();
    final _contact = _contactController!.text.trim();
    if (_name.isEmpty || _age.isEmpty || _email.isEmpty || _contact.isEmpty) {
      return;
    }
    final _student = StudentModel(
        name: _name,
        age: _age,
        email: _email,
        contacts: _contact,
        image: image!);
    updateStudent(widget.student.key, _student);
    showAddedAlertBox(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Student')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _formKey,
          child: ListView(children: <Widget>[
            imageProfile(context),
            const SizedBox(height: 20),
            textFormFieldFunctions(_nameController!, 'Full Name',
                validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter Full Name";
              }
              if (!RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
                  .hasMatch(value)) {
                return 'Please enter valid Name';
              }
              return null;
            }),
            const SizedBox(height: 20),
            textFormFieldFunctions(
              _ageController!,
              'Age',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter the Age";
                }
                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return 'Please enter a valid Age';
                }
              },
            ),
            const SizedBox(height: 20),
            textFormFieldFunctions(
              _emailController!,
              'Email',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter an email";
                }
                if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  return "Please enter a valid email";
                }
              },
            ),
            const SizedBox(height: 20),
            textFormFieldFunctions(
              _contactController!,
              'Contact Number',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a Contact number";
                }
                if (value.length != 10)
                  return 'Mobile Number must be of 10 digit';
              },
            ),
            const SizedBox(height: 20),
            editStudentButton(onAddStudentButtonClicked),
          ]),
        ),
      ),
    );
  }

  editStudentButton(onAddStudentButtonClicked()) {
    return Padding(
      padding: const EdgeInsets.only(left: 100.0, right: 90),
      child: ElevatedButton.icon(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            onAddStudentButtonClicked();
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Edit Student'),
      ),
    );
  }

  void showAddedAlertBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            title: Column(
              children: const [
                Text("Edit"),
                Divider(),
              ],
            ),
            content: const Text("Edited Successfully."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      ctx,
                      MaterialPageRoute(
                          builder: (context) => const ViewStudents()),
                      (route) => false);
                  // Navigator.pop(ctx);
                },
                child: const Text('Ok'),
              ),
            ],
          );
        });
  }

  Widget imageProfile(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 80.0,
            backgroundImage: (image != null)
                ? FileImage(File(image!))
                : AssetImage('assets/images/profile.png') as ImageProvider,
          ),
          Positioned(
            bottom: 20,
            right: 5,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context, builder: (ctx) => bottomsheet(ctx));
              },
              child: const Icon(
                Icons.camera_alt,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomsheet(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            'Choose Profile Photo',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  pickImage(source: ImageSource.camera);
                },
                icon: const Icon(Icons.camera),
                label: const Text('camera'),
              ),
              TextButton.icon(
                onPressed: () {
                  pickImage(source: ImageSource.gallery);
                },
                icon: const Icon(Icons.image),
                label: const Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget textFormFieldFunctions(
    TextEditingController controller, String labeltext,
    {required String? Function(dynamic value) validator}) {
  return TextFormField(
    validator: validator,
    controller: controller,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      labelText: labeltext,
      filled: true,
      fillColor: const Color.fromARGB(255, 230, 230, 18),
    ),
  );
}
