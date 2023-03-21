import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:no_name_ecommerce/services/category_service.dart';
import 'package:no_name_ecommerce/services/child_category_service.dart';
import 'package:no_name_ecommerce/services/search_product_service.dart';
import 'package:no_name_ecommerce/services/subcategory_service.dart';
import 'package:no_name_ecommerce/services/translate_string_service.dart';
import 'package:no_name_ecommerce/view/home/components/categories.dart';
import 'package:no_name_ecommerce/view/home/components/child_categories.dart';
import 'package:no_name_ecommerce/view/home/components/sub_categories.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/const_strings.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/custom_input.dart';
import 'package:no_name_ecommerce/view/utils/responsive.dart';
import 'package:provider/provider.dart';

class ProductFilter extends StatefulWidget {
  const ProductFilter({Key? key}) : super(key: key);

  @override
  State<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends State<ProductFilter> {
  int selectedCategory = 0;
  int selectedColor = 0;

  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<TranslateStringService>(
      builder: (context, ln, child) => Consumer<SearchProductService>(
        builder: (context, provider, child) => Container(
          height: screenHeight / 2 + 210,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
              horizontal: screenPadHorizontal, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleCommon(ln.getString(ConstString.filterBy) + ':'),
                gapH(20),

                //Category =====>
                paragraphCommon(ln.getString(ConstString.category) + ':'),
                gapH(12),
                const Categories(),

                //Sub Category =====>
                gapH(20),
                paragraphCommon(ln.getString(ConstString.subCategory) + ':'),
                gapH(12),
                const SubCategories(),

                //Child Category =====>
                gapH(20),
                paragraphCommon(ln.getString(ConstString.childCategory) + ':'),
                gapH(12),
                const ChildCategories(),

                //=========>
                // const ColorAndSize(),

                //Price range =========>
                gapH(18),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          paragraphCommon(
                              ln.getString(ConstString.minPrice) + ':'),
                          gapH(10),
                          CustomInput(
                            hintText: ln.getString(ConstString.enterMinPrice),
                            borderRadius: 5,
                            paddingHorizontal: 15,
                            isNumberField: true,
                            controller: minPriceController,
                            onChanged: (v) {
                              provider.setMinPrice(v);
                            },
                          ),
                        ],
                      ),
                    ),
                    gapW(20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          paragraphCommon(
                              ln.getString(ConstString.minPrice) + ':'),
                          gapH(10),
                          CustomInput(
                            hintText: ln.getString(ConstString.enterMaxPrice),
                            borderRadius: 5,
                            paddingHorizontal: 15,
                            isNumberField: true,
                            controller: maxPriceController,
                            onChanged: (v) {
                              provider.setMaxPrice(v);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                paragraphCommon(ln.getString(ConstString.ratings) + ':'),
                gapH(10),
                RatingBar.builder(
                  initialRating: provider.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                  itemSize: 30,
                  unratedColor: greyFive,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (value) {
                    provider.setRating(value);
                  },
                ),

                // Reset filter and apply button
                gapH(20),
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        provider.setRating(5.0);
                        Provider.of<CategoryService>(context, listen: false)
                            .setFirstValue();
                        Provider.of<SubCategoryService>(context, listen: false)
                            .setFirstValue();
                        Provider.of<ChildCategoryService>(context,
                                listen: false)
                            .setFirstValue();

                        Provider.of<SearchProductService>(context,
                                listen: false)
                            .setMinPrice('');
                        Provider.of<SearchProductService>(context,
                                listen: false)
                            .setMaxPrice('');

                        minPriceController.clear();
                        maxPriceController.clear();
                      },
                      child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          decoration: BoxDecoration(
                              color: const Color(0xffEAECF0),
                              borderRadius: BorderRadius.circular(100)),
                          child: Text(
                            ln.getString(ConstString.clear),
                            style: const TextStyle(
                              color: Color(0xff667085),
                              fontSize: 14,
                            ),
                          )),
                    )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: buttonPrimary(ConstString.apply, () {
                        Navigator.pop(context);
                      }, borderRadius: 100),
                    )
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
