import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfInvoiceService {
  Future<Uint8List> createHelloWorld(String Text) async {
    final image =
        (await rootBundle.load("assets/logo.png")).buffer.asUint8List();

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Image(pw.MemoryImage(image),
                    width: 150, height: 150, fit: pw.BoxFit.cover),
                pw.SizedBox(height: 50),
                pw.Center(
                  child: pw.Text(Text, style: const pw.TextStyle(fontSize: 30)),
                ),
                pw.SizedBox(height: 50),
                pw.Center(
                  child: pw.Text('PDF Maker by: Nasr Al-Rahbi',
                      style: const pw.TextStyle(fontSize: 20)),
                ),
              ]);
        },
      ),
    );

    return pdf.save();
  }
}
