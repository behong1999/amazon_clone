import 'package:amazon_clone/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String ip = dotenv.get("IP_ADDRESS", fallback: '');
String url = 'http://$ip:3000';

class GlobalVar {
  //*=============== COLORS ===============
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unSelectedNavBarColor = Colors.black87;

  static List<Map<String, String>> categories = [
    {
      'title': 'Essentials',
      'image': Assets.images.essentials.path,
    },
    {
      'title': 'Appliances',
      'image': Assets.images.appliances.path,
    },
    {
      'title': 'Books',
      'image': Assets.images.books.path,
    },
    {
      'title': 'Fashion',
      'image': Assets.images.fashion.path,
    },
    {
      'title': 'Mobiles',
      'image': Assets.images.mobiles.path,
    },
  ];

  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];
}
