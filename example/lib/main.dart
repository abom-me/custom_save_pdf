import 'package:custom_save_pdf/pdf_save/pdf_save.dart';
import 'package:flutter/material.dart';

import 'invoice_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController text = TextEditingController();

  final PdfInvoiceService service = PdfInvoiceService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: TextField(
                controller: text,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                final data = await service.createHelloWorld(text.text);

                CustomPdfFolder.save(
                    byteList: data,
                    nameOfFolder: 'folderName',
                    openPDF: true,
                    onSaved: (v) {},
                    onError: (error, code) {
                      print(error);
                      print(code);
                    });
              },
              child: const Text("Create PDF"),
            ),
          ],
        ),
      ),
    );
  }
}
