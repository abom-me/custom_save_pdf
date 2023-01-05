library custom_save_pdf;

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomPdfFolder {
  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>
  /// ###  Add The Uint8List From (PDF) Package
  /// #### <a href="https://pub.dev/packages/pdf"> PDF Package </a>
  /// #### <span style="color:green">  You Will find example in the document</span>

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>
  /// ### اضف كود
  /// ### Uint8List
  ///### بإمكانك الحصول عليه من باكج
  ///### PDF
  /// ### <a href="https://pub.dev/packages/pdf"> PDF Package </a>
  /// #### <span style="color:green">  سوف تجد أمثلة في مستندات الباكج</span>

  final Uint8List byteList;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>
  ///
  /// ### Write  Name for The folder, Where The PDF File Saving on it
  ///

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>

  /// ### أكتب أسم المجلد الذي تريد حفظ الملفات بداخله
  final String nameOfFolder;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>
  /// ### Write  name for the file, for example:

  /// #### (-- example.pdf --)
  /// <span style="color:#d80000"> Without (.pdf) </span>
  /// <br>
  /// <span style="color:green">You can keep it empty and will make random name</span>
  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>
  /// ### أكتب اسم للملف الذي تريد حفظه, مثال:
  /// #### (-- example.pdf --)

  /// <span style="color:#d80000"> بدون اضافة الامتداد (.pdf) </span>
  /// <br>
  /// <span style="color:green">بإمكانك تركه فارغا وسوف يقوم بإنشاء اسم عشوائي </span>

  final String? fileName;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>
  /// ### Here You can get the path of the pdf file as String

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>
  /// ### هنا يعطيك مسار الملف كنص

  final void Function(String filePath)? onSaved;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>
  /// ### Here showing you any error happen with the code of the error and you can add Function if there is any errors

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>
  /// ### هنا يظهر  نص و رقم الخطأ اذا حدثت اي اخطاء، و بإمكانك إعطائه امر ليفعله اذا عثر على خطأ

  final void Function(String error, int errorCode)? onError;

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- EN ----</p>
  /// ### keep it true to open the pdf file after save it
  /// ### or false to only saving in files
  /// <span style="color:green;font-size:13;font-weight: bold;">it's True by default  </span>

  /// <p style="color:#77b4ff;font-size:16;font-weight: bold;">---- AR ----</p>
  /// #### True
  /// #### لكي ينفتح الملف بعد حفظه
  /// #### False
  /// #### لكي يحفظ الملف فقط بدون فتحه
  bool? openPDF = true;

  CustomPdfFolder({
    this.onError,
    required this.nameOfFolder,
    this.fileName,
    required this.byteList,
    this.onSaved,
    this.openPDF,
  });

  CustomPdfFolder.save({
    this.onError,
    required this.byteList,
    required this.nameOfFolder,
    this.fileName,
    this.openPDF,
    this.onSaved,
  }) {
    permission();
  }
  permission() async {
    if (await Permission.contacts.request().isGranted) {}

    await Permission.storage.request();
    await Permission.manageExternalStorage.request();

    if (await Permission.storage.isGranted) {
      savePDF();
    } else {
      onError!('User Denied Access to the storage', 101);
    }
  }

  savePDF() async {
    String newPath = '';
    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
      List<String>? paths = directory?.path.split("/");
      for (int x = 1; x < paths!.length; x++) {
        String folder = paths[x];
        if (folder != "Android") {
          newPath += "/$folder";
        } else {
          break;
        }
      }
      newPath = "$newPath/$nameOfFolder";
      directory = Directory(newPath);

      await directory.create(recursive: true);
      save(directory);
    } else if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();

      newPath = "${directory.path}/$nameOfFolder";

      directory = Directory(newPath);
      await directory.create(recursive: true).catchError((e) {
        onError!(e.toString(), 102);
      });
      save(directory);
    }
  }

  save(
    Directory directory,
  ) async {
    var nameFile = fileName ?? '${DateTime.now()}_${getRandomString(10)}';

    var filePath = "${directory.path}/$nameFile.pdf";
    final file = File(filePath);
    await file
        .writeAsBytes(byteList)
        .then((value) => {
              onSaved!(filePath),
            })
        .catchError((onError) {
      onError!(onError.toString(), 103);
    });

    if (openPDF == true) {
      await OpenDocument.openDocument(filePath: filePath).catchError((onError) {
        onError!(onError.toString(), 104);
      });
    }
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length,
      (_) => 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890'
          .codeUnitAt(Random().nextInt(
              'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890'
                  .length))));
}
