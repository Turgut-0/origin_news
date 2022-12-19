import 'dart:io';
import 'dart:math';

import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mailer/mailer.dart';
import 'package:flutter_mailer/flutter_mailer.dart';

class Contacts_Helper {
  late List<Contact> contacts;
  late String Gl_path;
  late File Gl_file;




  void initState() {
    permissionContac();

  }


  Future permissionContac() async {
    await Permission.contacts.request();
    contacts = await ContactsService.getContacts();
    print('izin alma islemi! ');
  }

  print_contac() async {
    contacts =
        (await ContactsService.getContacts(withThumbnails: false)).toList();

    for (int i = 0; i < contacts.length; i++) {
      print(contacts[i].displayName);
      if (!contacts[i].phones!.isEmpty) {
        print(contacts[i].phones!.elementAt(0).value.toString());
      }
      if (!contacts[i].emails!.isEmpty) {
        print(contacts[i].emails!.elementAt(0).value.toString());
      }
      //print(contacts[i].emails!.elementAt(0).value.toString());
    }
    print('yazdirma islemi!');
  }

  Future directory_file() async {
    // 创建一个文件夹
    Directory tempDir = await getTemporaryDirectory();
    Directory directory = new Directory('${tempDir.path}/test');

    if (!directory.existsSync()) {
      directory.createSync();
      print('文档初始化成功，文件保存路径为 ${directory.path}');
    }

// 创建一个文件
    Directory _tempDir = await getTemporaryDirectory();

    File file = new File('${_tempDir.path}/test.txt');

    directory.listSync().forEach((file) {
      print(file.path);
    });
    print('文件路径${file.path}');

    if (!file.existsSync()) {
      file.createSync();
      print('test.txt创建成功');
      print('文件路径：${file.path}');
    }

    // write_File(file);
    // read_File(file);
  }




  write_File() async{
    File file= new File('assets/contacts.text');
    file.writeAsString('asdd', mode: FileMode.append);
    print('写入成功');

    // final _temp = await file.readAsString();
    // print('文件内容：\n' + '$_temp');

  }

  read_File(File file) async {
    final _temp = await file.readAsString();
    print('文件内容：\n' + '$_temp');
  }

  temp_List() async {
    List<Object> listContact = [];

    contacts =
        (await ContactsService.getContacts(withThumbnails: false)).toList();

    for (int i = 0; i < contacts.length; i++) {
      listContact.add('${contacts[i].displayName}');
      if (!contacts[i].phones!.isEmpty) {
        listContact.add('${contacts[i].phones!.elementAt(0).value.toString()}');
      }
    }
    print('List icerik:\n${listContact}');
  }


}
