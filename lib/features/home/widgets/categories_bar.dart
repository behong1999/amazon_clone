import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/screens/category_screen.dart';
import 'package:flutter/material.dart';

class CategoriesBar extends StatelessWidget {
  const CategoriesBar({Key? key}) : super(key: key);

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryScreen.routeName, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: GlobalVar.categories.length,
        scrollDirection: Axis.horizontal,
        itemExtent: 75,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => navigateToCategoryPage(
              context,
              GlobalVar.categories[index]['title']!,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      GlobalVar.categories[index]['image']!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                Text(
                  GlobalVar.categories[index]['title']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
