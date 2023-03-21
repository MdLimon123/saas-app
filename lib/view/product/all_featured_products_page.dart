import 'package:flutter/material.dart';
import 'package:flutterzilla_fixed_grid/flutterzilla_fixed_grid.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/services/featured_product_service.dart';
import 'package:no_name_ecommerce/services/translate_string_service.dart';
import 'package:no_name_ecommerce/view/home/components/product_card.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:no_name_ecommerce/view/utils/const_strings.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/responsive.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllFeaturedProductsPage extends StatefulWidget {
  const AllFeaturedProductsPage({Key? key}) : super(key: key);

  @override
  State<AllFeaturedProductsPage> createState() =>
      _AllFeaturedProductsPageState();
}

class _AllFeaturedProductsPageState extends State<AllFeaturedProductsPage> {
  @override
  void initState() {
    super.initState();
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarCommon(ConstString.allFeaturedProducts, context, () {
        Navigator.pop(context);
      }),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: context.watch<FeaturedProductService>().currentPage > 1
            ? false
            : true,
        onRefresh: () async {
          final result =
              await Provider.of<FeaturedProductService>(context, listen: false)
                  .fetchAllFeaturedProducts(context);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result =
              await Provider.of<FeaturedProductService>(context, listen: false)
                  .fetchAllFeaturedProducts(context);
          if (result) {
            debugPrint('loadcomplete ran');
            //loadcomplete function loads the data again
            refreshController.loadComplete();
          } else {
            debugPrint('no more data');
            refreshController.loadNoData();

            Future.delayed(const Duration(seconds: 1), () {
              //it will reset footer no data state to idle and will let us load again
              refreshController.resetNoData();
            });
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenPadHorizontal),
            child: Consumer<TranslateStringService>(
              builder: (context, ln, child) => Consumer<FeaturedProductService>(
                builder: (context, provider, child) => provider
                        .allFeaturedProducts.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            gapH(10),
                            GridView.builder(
                                gridDelegate: const FlutterzillaFixedGridView(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 25,
                                    crossAxisSpacing: 20,
                                    height: 230),
                                shrinkWrap: true,
                                itemCount: provider.allFeaturedProducts.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, i) {
                                  return ProductCard(
                                    imageLink: provider
                                            .allFeaturedProducts[i].imgUrl ??
                                        placeHolderUrl,
                                    title:
                                        provider.allFeaturedProducts[i].title,
                                    width: 200,
                                    oldPrice:
                                        provider.allFeaturedProducts[i].price,
                                    discountPrice: provider
                                        .allFeaturedProducts[i].discountPrice,
                                    marginRight: 5,
                                    productId:
                                        provider.allFeaturedProducts[i].prdId,
                                    ratingAverage: provider
                                        .allFeaturedProducts[i].avgRatting,
                                    discountPercent: provider
                                        .allFeaturedProducts[i]
                                        .campaignPercentage,
                                    pressed: () {
                                      gotoProductDetails(
                                          context,
                                          provider
                                              .allFeaturedProducts[i].prdId);
                                    },
                                  );
                                })
                          ])
                    : Container(
                        alignment: Alignment.center,
                        height: screenHeight - 200,
                        child: Text(ln.getString(ConstString.noProductFound)),
                      ),
              ),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: goToCartButton(context)
    );
  }
}
