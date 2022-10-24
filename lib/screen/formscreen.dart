import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/model/student.dart';
import 'package:form_field_validator/form_field_validator.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formkey = GlobalKey<FormState>();
  //สร้าง Offject Student
  Student student = Student(fname: '', lname: '', email: '', score: '');

  final emailvalidator = MultiValidator([
    RequiredValidator(errorText: "กรุณาป้อนอีเมล"),
    EmailValidator(errorText: "กรุณากรอกอีเมลให้ถูกต้อง")
  ]);

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final CollectionReference _studentCollection =
      FirebaseFirestore.instance.collection("student");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.hasError}"),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("แบบฟอร์มบันทึกคะแนนสอบ"),
              ),
              body: Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                    key: formkey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            "ชื่อ",
                            style: TextStyle(fontSize: 16),
                          ),
                          TextFormField(
                            onSaved: (fname) => {student.fname = fname!},
                            validator:
                                RequiredValidator(errorText: "กรุณาป้อนชื่อ"),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "นามสกุล",
                            style: TextStyle(fontSize: 16),
                          ),
                          TextFormField(
                            onSaved: (lname) => {student.lname = lname!},
                            validator: RequiredValidator(
                                errorText: "กรุณาป้อนนามสกุล"),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "อีเมล",
                            style: TextStyle(fontSize: 16),
                          ),
                          TextFormField(
                              validator: emailvalidator,
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (email) => {student.email = email!}),
                          const SizedBox(height: 10),
                          const Text(
                            "คะแนน",
                            style: TextStyle(fontSize: 16),
                          ),
                          TextFormField(
                              validator: RequiredValidator(
                                  errorText: "กรุณาป้อนคะแนน"),
                              keyboardType: TextInputType.number,
                              onSaved: (score) => {student.score = score!}),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                  Icons.save), //icon data for elevated button
                              label: const Text(
                                "บันทึกข้อมูล",
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  formkey.currentState?.save();

                                  await _studentCollection.add({
                                    "fname": student.fname,
                                    "lname": student.lname,
                                    "email": student.email,
                                    "score": student.score
                                  });
                                  formkey.currentState?.reset();
                                }
                              }, //label text
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
