// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/auth_services/signup_service.dart';
import 'package:no_name_ecommerce/services/cart_services/cart_service.dart';
import 'package:no_name_ecommerce/services/cart_services/delivery_address_service.dart';
import 'package:no_name_ecommerce/services/dropdowns_services/country_dropdown_service.dart';
import 'package:no_name_ecommerce/services/dropdowns_services/state_dropdown_services.dart';
import 'package:no_name_ecommerce/services/profile_service.dart';
import 'package:no_name_ecommerce/services/translate_string_service.dart';
import 'package:no_name_ecommerce/view/auth/signup/dropdowns/country_states_dropdowns.dart';
import 'package:no_name_ecommerce/view/checkout/create_account_on_checkout.dart';
import 'package:no_name_ecommerce/view/order/components/free_ship_option.dart';
import 'package:no_name_ecommerce/view/order/components/shipping_option.dart';
import 'package:no_name_ecommerce/view/utils/common_helper.dart';
import 'package:no_name_ecommerce/view/utils/const_strings.dart';
import 'package:no_name_ecommerce/view/utils/constant_colors.dart';
import 'package:no_name_ecommerce/view/utils/constant_styles.dart';
import 'package:no_name_ecommerce/view/utils/custom_input.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';

class DeliveryAddressPage extends StatefulWidget {
  const DeliveryAddressPage({Key? key}) : super(key: key);

  @override
  State<DeliveryAddressPage> createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var enteredDeliveryAddress =
        Provider.of<DeliveryAddressService>(context, listen: false)
            .enteredDeliveryAddress;
    var profileProvider = Provider.of<ProfileService>(context, listen: false);

    if (profileProvider.profileDetails?.userDetails.deliveryAddress != null) {
      savedDeliveryAddress();
    } else if (enteredDeliveryAddress.isEmpty) {
      addressFromProfile();
    } else {
      addressNewEntered();
    }
  }

  savedDeliveryAddress() {
    var savedAddress = Provider.of<ProfileService>(context, listen: false)
        .profileDetails
        ?.userDetails
        .deliveryAddress;

    fullNameController.text = savedAddress?.fullName ?? '';
    emailController.text = savedAddress?.email ?? '';
    phoneController.text = savedAddress?.phone ?? '';
    addressController.text = savedAddress?.address ?? '';
    cityController.text = savedAddress?.city ?? '';
  }

  addressNewEntered() {
    var enteredDeliveryAddress =
        Provider.of<DeliveryAddressService>(context, listen: false)
            .enteredDeliveryAddress;
    fullNameController.text = enteredDeliveryAddress['name'] ?? '';
    emailController.text = enteredDeliveryAddress['email'] ?? '';
    phoneController.text = enteredDeliveryAddress['phone'] ?? '';
    cityController.text = enteredDeliveryAddress['city'] ?? '';
    addressController.text = enteredDeliveryAddress['address'] ?? '';
  }

//==================>
  addressFromProfile() {
    var userDetails = Provider.of<ProfileService>(context, listen: false)
        .profileDetails
        ?.userDetails;

    fullNameController.text = userDetails?.name ?? '';
    emailController.text = userDetails?.email ?? '';
    phoneController.text = userDetails?.mobile ?? '';
    addressController.text = userDetails?.address ?? '';
    cityController.text = userDetails?.city ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarCommon('Delivery address', context, () {
        Navigator.pop(context);
      }),
      body: Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Consumer<ProfileService>(
            builder: (context, profileProvider, child) =>
                Consumer<TranslateStringService>(
              builder: (context, ln, child) => Consumer<DeliveryAddressService>(
                builder: (context, dProvider, child) => Consumer<CartService>(
                  builder: (context, cProvider, child) => Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenPadHorizontal, vertical: 25),
                    child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CountryStatesDropdowns(),

                            gapH(20),
                            //Name ============>
                            labelCommon(ConstString.fullName),

                            CustomInput(
                              controller: fullNameController,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return ln
                                      .getString(ConstString.plzEnterFullName);
                                }
                                return null;
                              },
                              hintText: ln.getString(ConstString.enterFullName),
                              // icon: 'assets/icons/user.png',
                              paddingHorizontal: 17,
                              textInputAction: TextInputAction.next,
                            ),
                            gapH(5),

                            //Email ============>
                            labelCommon(ConstString.email),

                            CustomInput(
                              controller: emailController,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return ln
                                      .getString(ConstString.plzEnterEmail);
                                }
                                return null;
                              },
                              hintText: ln.getString(ConstString.enterEmail),
                              // icon: 'assets/icons/email-grey.png',
                              paddingHorizontal: 17,
                              textInputAction: TextInputAction.next,
                            ),
                            gapH(5),

                            //Phone ============>
                            labelCommon(ConstString.phone),

                            CustomInput(
                              controller: phoneController,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return ln
                                      .getString(ConstString.plzEnterPhone);
                                }
                                return null;
                              },
                              hintText:
                                  ln.getString(ConstString.enterPhoneNumber),
                              isNumberField: true,
                              // icon: 'assets/icons/email-grey.png',
                              paddingHorizontal: 17,
                              textInputAction: TextInputAction.next,
                            ),

                            gapH(10),

                            //City /town ============>
                            labelCommon(ConstString.cityTown),

                            CustomInput(
                              controller: cityController,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return ln
                                      .getString(ConstString.plzEnterCityTown);
                                }
                                return null;
                              },
                              hintText: ln.getString(ConstString.enterCityTown),
                              // icon: 'assets/icons/email-grey.png',
                              paddingHorizontal: 17,
                              textInputAction: TextInputAction.next,
                            ),

                            gapH(5),

                            //Zip code ============>
                            labelCommon(ConstString.address),

                            CustomInput(
                              controller: addressController,
                              validation: (value) {
                                if (value == null || value.isEmpty) {
                                  return ln
                                      .getString(ConstString.plzEnterAddress);
                                }
                                return null;
                              },
                              hintText: ln.getString(ConstString.enterAddress),
                              paddingHorizontal: 17,
                              textInputAction: TextInputAction.next,
                            ),

                            gapH(5),
                            // Shipping options

                            dProvider.shippingCostDetails != null
                                ? dProvider.hasError != true
                                    ? Column(
                                        children: [
                                          //default shipping
                                          InkWell(
                                            onTap: () {
                                              var minOrder = dProvider
                                                      .shippingCostDetails
                                                      ?.defaultShippingOptions
                                                      .options
                                                      ?.minimumOrderAmount ??
                                                  0;
                                              var couponNeeded =
                                                  dProvider.checkIfCouponNeed(
                                                      dProvider
                                                          .shippingCostDetails
                                                          ?.defaultShippingOptions
                                                          .options
                                                          ?.coupon,
                                                      context);
                                              if (cProvider.subTotal <
                                                  minOrder) {
                                                showToast(
                                                    ln.getString(ConstString
                                                            .minimum) +
                                                        ' \$$minOrder ' +
                                                        ln.getString(ConstString
                                                            .orderIsNeeded),
                                                    Colors.black);
                                                return;
                                              } else if (couponNeeded) {
                                                showToast(
                                                    ln.getString(ConstString
                                                        .couponNeeded),
                                                    Colors.black);
                                                return;
                                              }

                                              dProvider.setShipIdAndCosts(
                                                  dProvider
                                                      .shippingCostDetails
                                                      ?.defaultShippingOptions
                                                      .options
                                                      ?.shippingMethodId,
                                                  dProvider
                                                          .shippingCostDetails
                                                          ?.defaultShippingOptions
                                                          .options
                                                          ?.cost ??
                                                      0,
                                                  dProvider
                                                      .shippingCostDetails
                                                      ?.defaultShippingOptions
                                                      .name,
                                                  context);

                                              setState(() {
                                                dProvider
                                                    .setSelectedShipIndex(-1);
                                              });
                                            },
                                            child: FreeShipOption(
                                              selectedShipping: dProvider
                                                  .selectedShippingIndex,
                                            ),
                                          ),

                                          //Other shipping option ======>
                                          for (int i = 0;
                                              i <
                                                  dProvider.shippingCostDetails!
                                                      .shippingOptions.length;
                                              i++)
                                            if (dProvider.shippingCostDetails!
                                                    .shippingOptions[i].id !=
                                                dProvider.shippingCostDetails!
                                                    .defaultShippingOptions.id)
                                              InkWell(
                                                onTap: () {
                                                  var minOrder = dProvider
                                                          .shippingCostDetails
                                                          ?.shippingOptions[i]
                                                          .options
                                                          ?.minimumOrderAmount ??
                                                      0;
                                                  var couponNeeded = dProvider
                                                      .checkIfCouponNeed(
                                                          dProvider
                                                              .shippingCostDetails
                                                              ?.shippingOptions[
                                                                  i]
                                                              .options
                                                              ?.coupon,
                                                          context);
                                                  if (cProvider.subTotal <
                                                      minOrder) {
                                                    showToast(
                                                        ln.getString(ConstString
                                                                .minimum) +
                                                            ' \$$minOrder ' +
                                                            ln.getString(ConstString
                                                                .orderIsNeeded),
                                                        Colors.black);
                                                    return;
                                                  } else if (couponNeeded) {
                                                    showToast(
                                                        ln.getString(ConstString
                                                            .couponNeeded),
                                                        Colors.black);

                                                    return;
                                                  }
                                                  dProvider.setShipIdAndCosts(
                                                      dProvider
                                                          .shippingCostDetails
                                                          ?.shippingOptions[i]
                                                          .options
                                                          ?.shippingMethodId,
                                                      dProvider
                                                          .shippingCostDetails
                                                          ?.shippingOptions[i]
                                                          .options
                                                          ?.cost,
                                                      dProvider
                                                          .shippingCostDetails
                                                          ?.shippingOptions[i]
                                                          .name,
                                                      context);

                                                  dProvider
                                                      .setSelectedShipIndex(i);
                                                },
                                                child: ShippingOption(
                                                    selectedShipping: dProvider
                                                        .selectedShippingIndex,
                                                    dProvider: dProvider,
                                                    i: i),
                                              ),
                                        ],
                                      )
                                    : Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 15),
                                        child: Text(
                                          ln.getString(
                                              ConstString.noShippingAvailable),
                                          style: const TextStyle(
                                              color: warningColor),
                                        ),
                                      )
                                : Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: showLoading(primaryColor),
                                  ),

                            if (profileProvider.profileDetails == null)
                              CreateAccountOnCheckout(
                                passController: passController,
                              ),

                            gapH(10),
                            Consumer<SignupService>(
                                builder: (context, rP, child) =>
                                    buttonPrimary(ConstString.save, () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (rP.isloading == true) {
                                          return;
                                        }

                                        var countryProvider =
                                            Provider.of<CountryDropdownService>(
                                                context,
                                                listen: false);
                                        var stateProvider =
                                            Provider.of<StateDropdownService>(
                                                context,
                                                listen: false);

                                        if (countryProvider.selectedCountryId ==
                                                defaultId ||
                                            stateProvider.selectedStateId ==
                                                defaultId) {
                                          showToast(
                                              ConstString
                                                  .mustSelectCountryState,
                                              Colors.black);
                                          return;
                                        }

                                        dProvider.enteredDeliveryAddress = {
                                          'name': fullNameController.text,
                                          'email': emailController.text,
                                          'phone': phoneController.text,
                                          'city': cityController.text,
                                          'pass': passController.text,
                                          'address': addressController.text
                                        };

                                        var res = await dProvider
                                            .registerUsingDeliveryAddress(
                                                context);

                                        if (res == true ||
                                            dProvider
                                                    .createAccountWithDeliveryDetails ==
                                                false) {
                                          Navigator.pop(context);
                                        }
                                      }
                                    }, isloading: rP.isloading)),
                          ]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
