import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/screen/formscreen.dart';
import 'package:flutterfirebase/screen/displayscreen.dart';
import 'package:flutterfirebase/screen/qrscan.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
              children: [FormScreen(), DisplayScreen(), QrscanScreen()]),
          backgroundColor: Colors.green,
          bottomNavigationBar: TabBar(tabs: [
            Tab(text: "บันทึกข้อมูล"),
            Tab(text: "รายการคะแนน"),
            Tab(text: "สแกนคิวอาร์โค้ด")
          ]),
        ));
  }

  // Future<Null> registerFirebase() async {
  //   await Firebase.initializeApp()
  //       .then((value) => {print('firebase initialize Success ')});
  // }
}
