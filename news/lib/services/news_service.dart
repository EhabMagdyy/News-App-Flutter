import 'package:dio/dio.dart';
import 'package:news/models/articles_model.dart';

class NewsService 
{
  final Dio dio;

  NewsService({required this.dio});

  Future<List<ArticlesModel>> getNews({required String category}) async {
    final Response response = await dio.get('https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    var jsonData = response.data;
    var status = jsonData["status"];
    if("ok" == status)
    {
      var totalResults = jsonData["totalResults"];
      if(0 < totalResults)
      {
        List<dynamic> articles = jsonData["articles"];
        List<ArticlesModel> topLinesArticles = [];

        for(var articel in articles)
        {
          if(null != articel["title"] && null != articel["description"] && null != articel["urlToImage"] && null != articel["url"])
          {
            topLinesArticles.add(ArticlesModel.fromJson(articel));
          }
        }
        return topLinesArticles;
      }
      return List<ArticlesModel>.generate(1, (index) => ArticlesModel(
              title: null,
              subTitle: null,
              url: null,
              image: null
            )); // No data
    }
    return List<ArticlesModel>.empty(); // Error
  }
}