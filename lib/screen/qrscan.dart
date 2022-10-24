import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:url_launcher/url_launcher.dart';

class QrscanScreen extends StatefulWidget {
  const QrscanScreen({super.key});

  @override
  State<QrscanScreen> createState() => _QrscanScreenState();
}

class _QrscanScreenState extends State<QrscanScreen> {
  String? scanresult;
  bool? checkLineURL = false;
  bool? checkFacebookURL = false;
  bool? checkYoutubeURL = false;
  final Uri _url = Uri.parse('https://flutter.dev');
  @override
  Widget build(BuildContext context) {
    // checkYoutubeURL = true;
    return Scaffold(
      appBar: AppBar(
        title: const Text("แสกนคิวอาร์โค้ด"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 300,
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "ผลการสแกน",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  Text(scanresult ??= "ยังไม่มีข้อมูล",
                      style: const TextStyle(fontSize: 15)),
                  const Spacer(),
                  checkLineURL!
                      ? SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () async {
                              // ignore: deprecated_member_use
                              if (await canLaunch(scanresult!)) {
                                // ignore: deprecated_member_use
                                await launch(scanresult!);
                              }
                            },
                            child: const Text('ติดตามผ่าน Line'),
                          ),
                        )
                      : Container(),
                  checkFacebookURL!
                      ? SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () async {
                              // ignore: deprecated_member_use
                              if (await canLaunch(scanresult!)) {
                                // ignore: deprecated_member_use
                                await launch(scanresult!);
                              }
                            },
                            child: const Text('ติดตามผ่าน Facebook'),
                          ),
                        )
                      : Container(),
                  checkYoutubeURL!
                      ? SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () async {
                              // ignore: deprecated_member_use
                              if (await canLaunch(scanresult!)) {
                                // ignore: deprecated_member_use
                                await launch(scanresult!);
                              }
                            },
                            child: const Text('ติดตามผ่าน Youtube'),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: startScan,
        child: const Icon(Icons.qr_code),
      ),
    );
  }

  startScan() async {
    String? cameraScanResult = await scanner.scan();

    setState(() {
      scanresult = cameraScanResult;
    });

    if (scanresult!.contains("line.me")) {
      checkLineURL = true;
    } else if (scanresult!.contains("facebook.com")) {
      checkFacebookURL = true;
    } else if (scanresult!.contains("youtube.com")) {
      checkYoutubeURL = true;
    }
  }
}
