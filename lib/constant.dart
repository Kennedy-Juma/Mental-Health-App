
import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromARGB(255, 40, 48, 109);
const kAccentColor = Color(0xFFF1F1F1);
const kWhiteColor = Color(0xFFFFFFFF);
const kLightColor =Color.fromARGB(255, 40, 48, 109);
const kDarkColor = Color(0xFF303030);
const kTransparent = Colors.transparent;

const kDefaultPadding = 20.0;
const kLessPadding = 10.0;
const kFixPadding = 16.0;
const kLess = 4.0;

const kShape = 30.0;

const kRadius = 0.0;
const kAppBarHeight = 56.0;

const kHeadTextStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  color: Color.fromARGB(255, 40, 48, 109)
);

const kSubTextStyle = TextStyle(
  fontSize: 18.0,
  color: kLightColor,
);

const kTitleTextStyle = TextStyle(
  fontSize: 20.0,
  color: kPrimaryColor,
);

const kDarkTextStyle = TextStyle(
  fontSize: 20.0,
  color: kDarkColor,
);

const kDivider = Divider(
  color: kAccentColor,
  thickness: kLessPadding,
);

const kSmallDivider = Divider(
  color: kAccentColor,
  thickness: 5.0,
);

const String pieChart = 'assets/images/what-we-do-illustration.png';
const String trophy = 'assets/images/megahealthlogo.png';
const String chat = 'assets/images/chatting.png';
const String whiteShape = 'assets/images/whitebg.svg';
const String logo = 'assets/images/megahealthlogo.png';
const String profile = 'assets/images/profile-avatar.jpg';
const String bg = 'assets/images/background.jpg';
const String profileBackground= 'assets/images/background-profile.jpg';
const String manShoes = 'assets/images/megahealthlogo.png';
const String success = 'assets/images/success.gif';
const String chatBubble = 'assets/images/chat.png';
const String emptyOrders = 'assets/images/orders.png';
const String callCenter = 'assets/images/center.png';
const String conversation = 'assets/images/conversation.png';
const String ProfilePic = 'assets/images/Kennedy.jpg';
const String MentalMealthBanner = 'assets/images/mental-health-banner-blue.jpg';

List<Map<String, String>> introData = [
  {
    'image': trophy,
    'headText': 'Who We are',
    'descText':
    "A well experienced insurance intermediary located in Nairobi offering the best solutions for your specific needs.",
  },
  {
    'image': pieChart,
    'headText': 'What We Do',
    'descText':
        "Easing insurance registration,card processing,authorisations and claims by the simple touch of a call button.",
  },

  {
    'image': chat,
    'headText': 'Chat With Us',
    'descText': "Have any inquiry/ question regarding our services? Worry not, our staff are available 24/7 to respond to you.",
  },
];

final labels = [
  'My Mood Tracker',
  'Settings',
  'About Application',
  'Logout',

];

final icons = [
  Icons.favorite,
  Icons.settings,
  Icons.info,
  Icons.logout,
];

final paymentLabels = [
  'Credit card / Debit card',
  'Cash on delivery',
  'Paypal',
  'Google wallet',
];

final paymentIcons = [
  Icons.credit_card,
  Icons.money_off,
  Icons.payment,
  Icons.account_balance_wallet,
];

final settingLabel = [
  'Settings',
  'My Profile',
  'Change Password',
  'Remain Anonymous',
];

List<String> chipsMobile = [
  "IPhone",
  "Samsung",
  "OnePlus",
  "RealMe",
  "Xiomi",
  "Oppo",
  "Vivo",
];

List<String> chipsCategory = [
  "Mobiles",
  "Cloths",
  "Electronics",
  "Furnitures",
  "Shoes",
  "Laptops",
  "Watches",
];

final List<String> sliderImages = [
  "assets/images/motor-vehicle-insurance.jpg",
  "assets/images/travel-insurance.jpg",
  "assets/images/health-insurance.jpg",
];

final menuLabels = [
  "Buy Insurance",
  "Downloads",
  "MegaCare Discounts",
  'Payments',


];

final menuIcons = [
  Icons.shopping_cart,
  Icons.download,
  Icons.medical_services,
  Icons.payment,
];



