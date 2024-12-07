
class ArticlesModel {
  final String? title;
  final String? subTitle;
  final String? url;
  final String? image;

  ArticlesModel({required this.title, required this.image, required this.subTitle, required this.url});

  factory ArticlesModel.fromJson(Map<String, dynamic> json) {
    return ArticlesModel(
      title: json["title"],
      subTitle: json["description"],
      url: json["url"],
      image: json["urlToImage"],
    );
  }
}