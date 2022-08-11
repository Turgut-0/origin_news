
import 'package:flutter/material.dart';
import 'package:origin_news/Helper/News.dart';
import 'package:origin_news/Helper/data.dart';

import 'package:url_launcher/url_launcher.dart';

import '../models/Category_model.dart';
import '../models/article_model.dart';
import 'package:cached_network_image/cached_network_image.dart';


import 'Category_view.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Categorymodel> category = <Categorymodel>[]; // 类别 信息

  List<Article_model> article = <Article_model>[]; // 主要新闻信息

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    category = getCategory();
    getNew();
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
            Text(
              'Haberler',
              style: TextStyle(color: Colors.blue),
            ),


          ],
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
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
                            return CategoryTile(category[index].image,
                                category[index].title,category[index].titleClon);
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
  final String networkImage, categoryName,clonName;


  CategoryTile(this.networkImage, this.categoryName, this.clonName);




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return Category_View(categoryName,clonName);
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
                ),*/CachedNetworkImage(
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
        onTap: () async{
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


