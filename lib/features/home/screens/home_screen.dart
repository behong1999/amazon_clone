import 'package:amazon_clone/common/widgets/app_bar.dart';
import 'package:amazon_clone/features/home/widgets/address_bar.dart';
import 'package:amazon_clone/features/home/widgets/carousel.dart';
import 'package:amazon_clone/features/home/widgets/categories_bar.dart';
import 'package:amazon_clone/features/home/widgets/deal_of_the_day.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressBar(),
            SizedBox(height: 10),
            CategoriesBar(),
            SizedBox(height: 10),
            Carousel(),
            DealOfDay(),
          ],
        ),
      ),
    );
  }
}
