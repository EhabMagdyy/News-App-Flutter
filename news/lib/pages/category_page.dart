import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news/models/articles_model.dart';
import 'package:news/services/news_service.dart';
import 'package:news/widgets/news_widget.dart';

class CategoryPage extends StatelessWidget
{
  final String categoryName;

  late final Future<List<ArticlesModel>> _newsFuture;

  CategoryPage({super.key, required this.categoryName}) {
    _newsFuture = NewsService(dio: Dio()).getNews(category: categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5E1),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFFFFF5E1)),
        backgroundColor: const Color(0xFF0C1844),
        toolbarHeight: 60.0,
        centerTitle: true,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "News",
              style: TextStyle(
                color: Color(0xFFFFF5E1),
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Mate",
              style: TextStyle(
                color: Color(0xFFFF6900),
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Sliver for News
          SliverPadding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
            sliver: SliverFillRemaining(
              child: FutureBuilder<List<ArticlesModel>>(
                future: _newsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                  {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  }
                  else if (snapshot.hasError)
                  {
                    return Center(
                      child: Text(
                        "Error loading news",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade600,
                        ),
                      ),
                    );
                  }
                  else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        "No news available",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    );
                  }
                  else
                  {
                    final news = snapshot.data!;
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: news.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: NewsWidget(model: news[index]),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
