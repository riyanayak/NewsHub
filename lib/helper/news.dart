import 'dart:convert';
import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart' as http;
class News{

  List<ArticleModel> news =[];
  Future<void> getNews() async{

    String url= "https://newsapi.org/v2/top-headlines?country=in&apiKey=983c72ab0c5943189f939d9467f1d549";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if(jsonData['status']=="ok"){
      jsonData["articles"].forEach((element){

        if(element["urlToImage"]!=null && element["description"]!=null){
          ArticleModel articleModel= ArticleModel(
              author: element["author"],
              title: element["title"],
              url: element["url"],
              description: element["description"],
              content: element["content"],
              urlToImage: element["urlToImage"],
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNews{

  List<ArticleModel> news =[];

  Future<void> getNews(String category) async{

    String url= "https://newsapi.org/v2/top-headlines?category=$category&country=in&apiKey=983c72ab0c5943189f939d9467f1d549";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if(jsonData['status']=="ok"){
      jsonData["articles"].forEach((element){

        if(element["urlToImage"]!=null && element["description"]!=null){
          ArticleModel articleModel= ArticleModel(
            author: element["author"],
            title: element["title"],
            url: element["url"],
            description: element["description"],
            content: element["content"],
            urlToImage: element["urlToImage"],
          );
          news.add(articleModel);
        }
      });
    }
  }
}