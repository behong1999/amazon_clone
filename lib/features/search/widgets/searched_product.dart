import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  double calculateAverageRating() {
    double totalRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }
    return totalRating != 0 ? totalRating / product.rating!.length : 0;
  }

  @override
  Widget build(BuildContext context) {
    double avgRating = calculateAverageRating();

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 135,
                width: 135,
              ),
              // Column(
              //   children: [
              //     Container(
              //       width: 235,
              //       margin: const EdgeInsets.symmetric(horizontal: 10),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             product.name,
              //             style: const TextStyle(
              //               fontSize: 16,
              //             ),
              //             maxLines: 2,
              //           ),
              //           const SizedBox(height: 5),
              //           Stars(
              //             rating: avgRating,
              //           ),
              //           const SizedBox(height: 5),
              //           Text(
              //             '\$${product.price}',
              //             style: const TextStyle(
              //               fontSize: 20,
              //               fontWeight: FontWeight.bold,
              //             ),
              //             maxLines: 2,
              //           ),
              //           const Text('Eligible for FREE Shipping'),
              //           const SizedBox(height: 5),
              //           const Text(
              //             'In Stock',
              //             style: TextStyle(
              //               color: Colors.teal,
              //             ),
              //             // maxLines: 2,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Stars(
                      rating: avgRating,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text('Eligible for FREE Shipping'),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: const Text(
                      'In Stock',
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                      //TODO: try removing maxLines to see the differences
                      // maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
