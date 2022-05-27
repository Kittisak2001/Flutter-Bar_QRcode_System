import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(title: 'Scan Bar_QR Code'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? scanresult;

  bool checkLineURL = false, checkFacebookURL = false, checkYoutubeURL = false;

  @override
  Widget build(BuildContext context) {
    checkLineURL = false;
    checkFacebookURL = false;
    checkYoutubeURL = true;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SizedBox(
              height: 300,
              width: double.infinity,
              child: Card(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ผลการสแกน",
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        scanresult =
                            "https://www.youtube.com/channel/UCKWp4QbICmcrLN5vNphcCWQ",
                        style: TextStyle(fontSize: 25),
                      ),
                      Spacer(),
                      checkLineURL
                          ? SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                onPressed: () {
                                  //     launch(scanresult!);
                                },
                                color: Colors.green[900],
                                child: Text(
                                  "Open Line",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Spacer(),
                      checkFacebookURL
                          ? SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                onPressed: () {
                                  // launch(scanresult!);
                                },
                                color: Colors.blue[900],
                                child: Text(
                                  "Open Facebook",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Spacer(),
                      checkYoutubeURL
                          ? SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                onPressed: () {
                                  launch(scanresult!);
                                },
                                color: Colors.red[900],
                                child: Text(
                                  "Open Youtube",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ]),
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: startScan,
        child: Icon(Icons.qr_code_scanner_sharp),
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
