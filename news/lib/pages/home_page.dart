import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news/models/articles_model.dart';
import 'package:news/pages/category_page.dart';
import 'package:news/services/news_service.dart';
import 'package:news/widgets/home_category_widget.dart';
import 'package:news/models/home_category_model.dart';
import 'package:news/widgets/news_widget.dart';

class HomePage extends StatelessWidget
{
  final List<HomeCategoryModel> categories = [
    HomeCategoryModel(name: "Sports", image: "assets/sports.jpeg"),
    HomeCategoryModel(name: "Business", image: "assets/business.jpeg"),
    HomeCategoryModel(name: "Science", image: "assets/science.jpeg"),
    HomeCategoryModel(name: "Technology", image: "assets/technology.jpeg"),
    HomeCategoryModel(name: "Health", image: "assets/health.jpeg"),
    HomeCategoryModel(name: "Entertainment", image: "assets/entertaiment.jpeg"),
  ];

  late final Future<List<ArticlesModel>> _newsFuture;

  HomePage({super.key}) {
    _newsFuture = NewsService(dio: Dio()).getNews(category: "general");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5E1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C1844),
        toolbarHeight: 60.0,
        title: const Row(
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
          // Sliver for Categories
          SliverAppBar(
            backgroundColor: const Color(0xFFFFF5E1),
            expandedHeight: 140,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      GestureDetector(
                        child: HomeCategoryWidget(model: categories[index]),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CategoryPage(categoryName: categories[index].name.toLowerCase()),
                            ),
                          );
                        },
                      ),
                      if (index < categories.length - 1)
                        const Padding(padding: EdgeInsets.only(right: 10)),
                    ],
                  );
                },
              ),
            ),
            floating: false, // Allows it to scroll out of view
          ),
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
