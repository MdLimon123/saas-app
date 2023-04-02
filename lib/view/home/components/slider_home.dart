import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/rtl_service.dart';
import 'package:no_name_ecommerce/services/slider_service.dart';
import 'package:no_name_ecommerce/view/product/products_by_category_page.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';

class SliderHome extends StatelessWidget {
  const SliderHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SliderService>(
      builder: (context, sliderProvider, child) => sliderProvider
              .sliderImageList.isNotEmpty
          ? SizedBox(
              height: 175,
              width: double.infinity,
              child: CarouselSlider.builder(
                itemCount: sliderProvider.sliderImageList.length,
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: false,
                  viewportFraction: 0.9,
                  aspectRatio: 2.0,
                  initialPage: 1,
                ),
                itemBuilder: (BuildContext context, int i, int pageViewIndex) =>
                    Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: sliderProvider.sliderImageList[i].image ??
                              placeHolderUrl,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Consumer<RtlService>(
                      builder: (context, rtlP, child) => Positioned(
                          left: rtlP.direction == 'ltr' ? 25 : 0,
                          right: rtlP.direction == 'ltr' ? 0 : 25,
                          top: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  '${sliderProvider.sliderImageList[i].title}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: greyFour,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  '${sliderProvider.sliderImageList[i].description}',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: greyFour,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (sliderProvider
                                      .sliderImageList[i].buttonText !=
                                  null)
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductsByCategoryPage(
                                                    categoryName: sliderProvider
                                                        .sliderImageList[i]
                                                        .category,
                                                  )));
                                    },
                                    child: Text(sliderProvider
                                            .sliderImageList[i].buttonText ??
                                        ''))
                            ],
                          )),
                    )
                  ],
                ),
              ),
            )
          : showLoading(primaryColor),
    );
  }
}
