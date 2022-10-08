import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/view/home/components/product_card.dart';
import 'package:no_name_ecommerce/view/home/components/section_title.dart';
import 'package:no_name_ecommerce/view/product/all_featured_products_page.dart';
import 'package:no_name_ecommerce/view/product/product_details_page.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';

import 'package:provider/provider.dart';

class FeaturedProducts extends StatelessWidget {
  const FeaturedProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          cc: cc,
          title: 'Featured products',
          pressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    const AllFeaturedProductsPage(),
              ),
            );
          },
        ),
        const SizedBox(
          height: 14,
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          height: 295,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            clipBehavior: Clip.none,
            children: [
              for (int i = 0; i < 5; i++)
                ProductCard(
                    imageLink:
                        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1099&q=80',
                    title: 'Black T-Shirt',
                    width: 180,
                    marginRight: 20,
                    pressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const ProductDetailsPage(),
                        ),
                      );
                    },
                    price: 32.99,
                    camapaignId: 1)
            ],
          ),
        ),
      ],
    );
  }
}