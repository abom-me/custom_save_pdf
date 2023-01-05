# custom_save_pdf:


###  باكج فلاتر يسمح لك بحفظ ملفات البي دي اف في مجلد مخصص على الهاتف

------------------

### Change To  [English](README.md) Version

-------------------
### #  *:👨‍💻تم تطوير هذا الباكج من قبِل*  

<img alt="profile" src="https://abom.me/packages/profile.png" width="50" height="50"  style=" border-radius: 100%"/>

**Nasr Al-Rahbi [@abom_me](https://twitter.com/abom_me)**

## 👨🏻‍💻 أضفني هنا  :
[![Twitter](https://img.shields.io/badge/Twitter-%231DA1F2.svg?logo=Twitter&logoColor=white)](https://twitter.com/abom_me)
[![Instagram](https://img.shields.io/badge/Instagram-%23E4405F.svg?logo=Instagram&logoColor=white)](https://instagram.com/abom.me)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-%230077B5.svg?logo=linkedin&logoColor=white)](https://linkedin.com/in/nasr-al-rahbi-08a573245)
[![Stack Overflow](https://img.shields.io/badge/-Stackoverflow-FE7A16?logo=stack-overflow&logoColor=white)](https://stackoverflow.com/users/19994059/nasr-al-rahbi)

---------------
<br>


**custom_save_pdf:** using the official [open_document](https://pub.dev/packages/open_document) & [path_provider](https://pub.dev/packages/path_provider) & [permission_handler](https://pub.dev/packages/permission_handler).
<br>
<br>
### ⚠️ المتطلبات ⚠️ :

|             | Android   | iOS    |
| ----------- |-----------| ------ | 
| **Support** | 	SDK  29+ | iOS 11+ 




## التنصيب:

اضف الباكج في المشروع
<br>
<br>
Pubspec :

```
      dependencies:
        custom_save_pdf: <last_verison>
```
مثال بسيط: 

```dart
import 'package:custom_save_pdf/custom_save_pdf.dart';

CustomPdfFolder.save(
byteList: data,
nameOfFolder: 'nasr',
openPDF: true,
onSaved: (v) {},
onError: (error, code) {
print(error);
print(code);
});
```

## بدأ التثبيت


- **يجب عليك اتباع جميع الخطوات بحرص تام لكي لا تواجه أي مشاكل**
<details>
 <summary style="font-size: 15px">-----Android-----------</summary>


1. قم بتغيير رقم ال 
   <br>
`minSdkVersion`
  <br>
 في
   <br>
 `android/app/build.gradle` :




```groovy
android {
    defaultConfig {
        minSdkVersion 29
    }
}
```

2-  عليك التأكد بتغيير ال 
<br>
`compileSdkVersion`
<br>in
<br>`android/app/build.gradle` :




```groovy
android {
    compileSdkVersion 33
    ...
}
```

3-  اضف هذا الكود في ال
<br>
`android/app/build.gradle` :




```xml

<!-- اولا اضف هذه الاسطر  -->
 <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.INTERNET" />


<application
        <!-- الان اضف هذا السطر في ال   -->
        <!-- application   -->
android:requestLegacyExternalStorage="true"
...
        >

        <!--  اضف هذا الكود بداخل ال   -->
        <!-- application   -->

<provider
android:name="androidx.core.content.FileProvider"
android:authorities="{the pakage of app}.{the app name}.fileprovider"
android:exported="false"
android:grantUriPermissions="true">
<meta-data
        android:name="android.support.FILE_PROVIDER_PATHS"
        android:resource="@xml/provider_paths" />
</provider>

```

3- اذهب الى
<br>
android/app/src/main/res
<br>
وأنشئ مجلد جديد باسم:
<br>
xml 
و الان انشئ بداخله:
<br>
provider_paths.xml
```xml

<!-- اضف هذا الكود بداخل:  -->
<!--  provider_paths.xml  -->

<?xml version="1.0" encoding="utf-8"?>
<paths>
    <external-path
            name="external_files"
            path="." />
</paths>
```
</details>
<br>
<br>
<br>
<details>
 <summary style="font-size: 15px">-----IOS-----------</summary>

### ملاحظة:
في الايفون سوف يتم انشاء و حفظ مجلدك    بداخل المجلد الخاص بالتطبيق اسمه نفس اسم التطبيق، في تطبيق الملفات

<br>
<br>
<br>
1- اضف هذا الكود في:
<br>info.plist:

````plist
 <key>LSSupportsOpeningDocumentsInPlace</key>
    <true/>
````
</details>


### -------------------------------------------------

See the `example` directory for a complete sample app.


### Parameters of the CustomPdfFolder

```dart
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

```
