// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/cart_services/cart_service.dart';
import 'package:no_name_ecommerce/services/rtl_service.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:provider/provider.dart';

import '../../utils/constant_colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.imageLink,
    required this.title,
    required this.width,
    required this.marginRight,
    required this.pressed,
    required this.productId,
    required this.oldPrice,
    required this.discountPrice,
    required this.ratingAverage,
    this.ratingCount,
    this.discountPercent,
  }) : super(key: key);

  final productId;
  final imageLink;
  final title;
  final oldPrice;
  final discountPrice;
  final ratingAverage;
  final ratingCount;
  final discountPercent;
  final double width;
  final double marginRight;
  final VoidCallback pressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pressed,
      child: Consumer<CartService>(
        builder: (context, cProvider, child) => Consumer<RtlService>(
          builder: (context, rtlP, child) => Container(
            alignment: Alignment.center,
            width: width,
            margin: EdgeInsets.only(
              right: rtlP.direction == 'ltr' ? marginRight : 0,
              left: rtlP.direction == 'ltr' ? 0 : marginRight,
            ),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(9)),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        height: 150,
                        width: double.infinity,
                        imageUrl: imageLink,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),

                    // off percent / discount
                    if (discountPercent != null)
                      Positioned(
                          right: 6,
                          top: 6,
                          child: Container(
                            color: primaryColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            child: paragraphCommon('$discountPercent% off',
                                color: Colors.white),
                          ))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    gapH(10),
                    //Title
                    Text(
                      title.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: blackCustomColor,
                          fontSize: 14,
                          height: 1.3,
                          fontWeight: FontWeight.w600),
                    ),

                    gapH(5),
                    //Price
                    Row(
                      children: [
                        paragraphCommon('\$$discountPrice',
                            lineHeight: 1.2,
                            fontsize: 14,
                            color: primaryColor,
                            fontweight: FontWeight.w600),

                        const SizedBox(
                          width: 7,
                        ),

                        //old price
                        Text(
                          '\$$oldPrice',
                          style: TextStyle(
                              color: Colors.grey[600],
                              decoration: TextDecoration.lineThrough),
                        )
                      ],
                    ),

                    gapH(5),

                    //Rating
                    if (ratingAverage != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: orangeColor,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          paragraphCommon(ratingAverage.toString(),
                              lineHeight: 1,
                              fontsize: 13,
                              color: greyParagraph,
                              fontweight: FontWeight.bold),
                          const SizedBox(
                            width: 5,
                          ),
                          if (ratingCount != null)
                            paragraphCommon('($ratingCount)',
                                lineHeight: 1, fontsize: 13)
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
