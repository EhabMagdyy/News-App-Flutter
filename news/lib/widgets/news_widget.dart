import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news/models/articles_model.dart';
import 'package:news/pages/news_web_view_page.dart';

class NewsWidget extends StatelessWidget {
  final ArticlesModel model;

  const NewsWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewsWebViewPage(url: model.url ?? 'https://www.youtube.com/@EhabMagdyy'),
          ),
        );
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              imageUrl: model.image ??
                  'https://th.bing.com/th/id/R.1c84b2cecc5511457427e1535118cc03?rik=WoWSs85sioCOUQ&riu=http%3a%2f%2fwww.acdif.fr%2fwp-content%2fuploads%2f2018%2f06%2fbreaking-news-broadcast-graphics-title-footage-009796250_prevstill.jpeg&ehk=xpFVHfIIZqruu31lZeKwx1nmTZz%2br95099KCvckEfX4%3d&risl=&pid=ImgRaw&r=0',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200.0,
              placeholder: (context, url) => Container(
                width: double.infinity,
                height: 200.0,
                color: Colors.grey.shade200,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Image.network(
                'https://th.bing.com/th/id/R.1c84b2cecc5511457427e1535118cc03?rik=WoWSs85sioCOUQ&riu=http%3a%2f%2fwww.acdif.fr%2fwp-content%2fuploads%2f2018%2f06%2fbreaking-news-broadcast-graphics-title-footage-009796250_prevstill.jpeg&ehk=xpFVHfIIZqruu31lZeKwx1nmTZz%2br95099KCvckEfX4%3d&risl=&pid=ImgRaw&r=0',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 4)),
          Text(
            model.title ?? 'No Title',
            maxLines: 2,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            model.subTitle ?? 'No Subtitle',
            maxLines: 1,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
