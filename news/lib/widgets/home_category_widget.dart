import 'package:flutter/material.dart';
import 'package:news/models/home_category_model.dart';

class HomeCategoryWidget extends StatelessWidget{
  final HomeCategoryModel model;
  const HomeCategoryWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(model.image),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
      width: 200.0,
      child: Center(
        child: Text(
          model.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 27.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}