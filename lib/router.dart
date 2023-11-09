import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/category_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/features/order_details/screens/order_details_screen.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const HomeScreen(), settings: routeSettings);

    case AuthScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const AuthScreen(), settings: routeSettings);

    case AddProductScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const AddProductScreen(), settings: routeSettings);

    case CategoryScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => CategoryScreen(category: category),
        settings: routeSettings,
      );

    case SearchScreen.routeName:
      var query = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => SearchScreen(searchQuery: query),
        settings: routeSettings,
      );

    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        builder: (_) => ProductDetailScreen(product: product),
        settings: routeSettings,
      );

    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        builder: (_) => OrderDetailScreen(order: order),
        settings: routeSettings,
      );

    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(totalAmount: totalAmount),
      );

    case BottomBar.routeName:
      return MaterialPageRoute(
          builder: (_) => const BottomBar(), settings: routeSettings);

    default:
      return MaterialPageRoute(
          builder: (_) => const Text('This page does not exist'));
  }
}
