class ApiUrl {
  static const String baseUri = 'https://hexfashion.xyz/api/tenant/v1';
  // static const String baseUri = 'https://electro.nazmart.net/api/tenant/v1';

  static const String refundProductsListUri = '$baseUri/user/refund';
  static const String loginUri = '$baseUri/login';
  static const String registerUri = '$baseUri/register';
  static const String logoutUri = '$baseUri/user/logout';
  static const String checkoutUri = '$baseUri/checkout';
  static const String changePassUri = '$baseUri/user/change-password';
  static const String searchItemsUri = '$baseUri/search-items';
  static const String usernameCheckUri = '$baseUri/username';
  static const String sendOtpUri = '$baseUri/send-otp-in-mail';
  static const String otpSuccessUri = '$baseUri/otp-success';
  static const String socialLoginUri = '$baseUri/social-login';
  static const String resetPassUri = '$baseUri/reset-password';
  static const String couponUri = '$baseUri/coupon';
  static const String shippingCostUri = '$baseUri/shipping-charge';
  static const String vatAndShipCostUri = '$baseUri/checkout-calculate?country';
  static const String departmentUri = '$baseUri/user/get-department';
  static const String gatewayListUri = '$baseUri/payment-gateway-list';
  static const String addShippingUri = '$baseUri/user/add-shipping-address';
  static const String stateSearchUri = '$baseUri/search/state';
  static const String citySearchUri = '$baseUri/search/city';
  static const String countrySearchUri = '$baseUri/search/country';
  static const String paymentUpdateUri = '$baseUri/update-payment';
  static const String removeShippingUri =
      '$baseUri/user/shipping-address/delete';
  static const String shipAddressListUri = "$baseUri/user/all-shipping-address";
  static const String ticketPriorityChangeUri =
      '$baseUri/user/ticket/priority-change';
  static const String ticketStatusChangeUri =
      '$baseUri/user/ticket/status-change';
  static const String createTicketUri = '$baseUri/user/ticket/create';
  static const String createRefundTicketUri =
      '$baseUri/user/refund-ticket/create';
  static const String ticketMessageUri = '$baseUri/user/ticket';
  static const String refundTicketMessageUri = '$baseUri/user/refund-ticket';
  static const String ticketMessageSendUri = '$baseUri/user/ticket/chat/send';
  static const String refundTicketMessageSendUri =
      '$baseUri/user/refund-ticket/chat/send';
  static const String ticketListUri = '$baseUri/user/ticket?page';
  static const String refundTicketListUri = '$baseUri/user/refund-ticket?page';
  static const String campaignProductsUri = '$baseUri/campaign/product';
  static const String featuredProductsUri = '$baseUri/featured/product';
  static const String recentProductsUri = '$baseUri/recent/product';
  static const String campaignListUri = '$baseUri/campaign';
  static const String categoryUri = '$baseUri/category';
  static const String childCategoryUri = '$baseUri/child-category';
  static const String stateListUri = '$baseUri/state';
  static const String cityListUri = '$baseUri/city';
  static const String countryListUri = '$baseUri/country';
  static const String currencyUri = '$baseUri/get-currency-symbol';
  static const String discoverProductsUri = '$baseUri/product?name=&page';
  static const String introUri = '$baseUri/mobile-intro';
  static const String privacyPolicyUri = '$baseUri/privacy-policy-page';
  static const String termsUri = '$baseUri/terms-and-condition-page';
  static const String productDetailsUri = '$baseUri/product';
  static const String updateProfileUri = '$baseUri/user/update-profile';
  static const String profileDataUri = '$baseUri/user/profile';
  static const String deleteAccountUri = '$baseUri/user/account/delete';
  static const String rtlUri = '$baseUri/site-currency-symbol';
  static const String languageUri = '$baseUri/language';
  static const String searchUri = '$baseUri/product';
  static const String sliderUri = '$baseUri/mobile-slider';
  static const String subcategoryUri = '$baseUri/subcategory';
  static const String translateUri = '$baseUri/translate-string';
  static const String orderListUri = '$baseUri/user/order';
  static const String refundProductUri = '$baseUri/user/order/refund';
  static const String writeReviewUri = '$baseUri/product-review';
}
