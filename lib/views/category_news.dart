import 'package:flutter/material.dart';
import 'package:news_app/views/article_view.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/helper/news.dart';

class CategoryView extends StatefulWidget {

  final String? category;
  CategoryView({ this.category});
  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {

  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState(){
    super.initState();
    getCategoryNews();
  }
  getCategoryNews() async {
    CategoryNews newsClass = CategoryNews();
    await newsClass.getNews(widget.category!);
    articles = newsClass.news;

    setState((){
      _loading=false;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("News",style:TextStyle(color: Colors.black),),
            Text("Hut",style:TextStyle(color: Colors.blueAccent),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.save)),
          )
        ],
        elevation: 0.0,
      ),
      body:  _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ): SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[

              ///Category_Blogs
              Container(
                padding:EdgeInsets.only(top: 16),
                child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index){
                      return BlogTile(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        description: articles[index].description,
                        url: articles[index].url,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {

  final String? imageUrl, title, description, url;
  BlogTile({required this.imageUrl,required this.title,required this.description,required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>ArticleView(
              blogUrl: url,
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.network(imageUrl!)
            ),
            SizedBox(height: 8,),
            Text(title!, style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),),
            SizedBox(height: 8,),
            Text(description!,style: TextStyle(
                color: Colors.black54
            ),),
          ],
        ),
      ),
    );
  }
}
