import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/product_details_service.dart';
import 'package:no_name_ecommerce/view/checkout/components/cart_icon.dart';
import 'package:no_name_ecommerce/view/product/components/campaign_timer.dart';
import 'package:no_name_ecommerce/view/product/components/color_size.dart';
import 'package:no_name_ecommerce/view/product/components/description_tab.dart';
import 'package:no_name_ecommerce/view/product/components/product_details_bottom.dart';
import 'package:no_name_ecommerce/view/product/components/product_details_increase_qty.dart';
import 'package:no_name_ecommerce/view/product/components/product_details_skeleton.dart';
import 'package:no_name_ecommerce/view/product/components/product_details_slider.dart';
import 'package:no_name_ecommerce/view/product/components/product_details_top.dart';
import 'package:no_name_ecommerce/view/product/components/review_tab.dart';
import 'package:no_name_ecommerce/view/product/components/ship_return_tab.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    Key? key,
    required this.productId,
  }) : super(key: key);

  final productId;

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _tabIndex = 0;

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  int currentTab = 0;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);

    Provider.of<ProductDetailsService>(context, listen: false)
        .fetchProductDetails(context, productId: widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: greyFour),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 25, top: 10),
            child: const CartIcon(),
          )
        ],
      ),
      body: Consumer<ProductDetailsService>(
        builder: (context, provider, child) => provider.productDetails != null
            ? Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Slider =============>
                            const ProductDetailsSlider(),

                            sizedboxCustom(16),

                            paragraphCommon('Unit: 1 Pcs  |  SKU: bbs15'),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const ProductDetailsTop(),

                                //=========>
                                const ColorAndSize(),

                                //increase decrease button
                                sizedboxCustom(17),
                                paragraphCommon('Quantity:'),
                                sizedboxCustom(10),
                                const ProductDetailsIncreaseQty(),

                                sizedboxCustom(25),

                                const CampaignTimer(),

                                //========>
                                // tab
                                sizedboxCustom(15),

                                TabBar(
                                  onTap: (value) {
                                    setState(() {
                                      currentTab = value;
                                    });
                                  },
                                  labelColor: primaryColor,
                                  unselectedLabelColor: greyFour,
                                  indicatorColor: primaryColor,
                                  unselectedLabelStyle: const TextStyle(
                                      color: greyParagraph,
                                      fontWeight: FontWeight.normal),
                                  controller: _tabController,
                                  tabs: const [
                                    Tab(text: 'Description'),
                                    Tab(text: 'Review'),
                                    Tab(text: 'Ship & return'),
                                  ],
                                ),

                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 15, bottom: 30),
                                  child: [
                                    const DescriptionTab(),
                                    const ReviewTab(),
                                    const ShipReturnTab(),
                                  ][_tabIndex],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  //=======>
                  ProductDetailsBottom(
                    tabIndex: currentTab,
                  )
                ],
              )
            : const ProductDetailsSkeleton(),
      ),
    );
  }
}
