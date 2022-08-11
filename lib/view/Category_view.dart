import 'package:flutter/material.dart';
import 'package:origin_news/Helper/News.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/article_model.dart';


class Category_View extends StatefulWidget {
  final String category,clonName ;

  Category_View(this.category,this.clonName);

  @override
  State<Category_View> createState() => _Category_ViewState();
}

class _Category_ViewState extends State<Category_View> {
  List<Article_model> article = <Article_model>[];

  bool _loading = true;

  getNew() async {
    Category_News news = Category_News();
    await news.getNews(widget.category);
    article = news.article;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getNew();
    super.initState();

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
              widget.clonName,
              style:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),

          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.share,)),
          )
        ],
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
              Image.network(
                urltoImage,
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
}
