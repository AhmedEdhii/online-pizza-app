// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_pizza/constant/colors.dart';

class Styles {
  Styles._();

  //for main headlings like the pizza name, login heading, etc.
  static final H1 = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeights.semiBold,
    color: MyColors.mainHeadingColor,
  );

  static final H1Primary = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeights.bold,
    color: MyColors.primaryColor,
  );
  static final SH1Primary = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeights.bold,
    color: MyColors.primaryColor,
  );

  // for UI headings like featured products, restaurants, etc.
  static final H2 = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeights.regular,
    color: MyColors.mainHeadingColor,
  );

  static final H2Bold = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeights.bold,
    color: MyColors.mainHeadingColor,
  );

  //for headings like Pizza names within cards and topbar headings on each page like My Orders, Cart, etc.
  static final H3 = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeights.medium,
    color: MyColors.mainHeadingColor,
  );

  static final H3Medium = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeights.medium,
    color: MyColors.mainHeadingColor,
  );

  static final H3Bold = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeights.bold,
    color: MyColors.mainHeadingColor,
  );

  static final H3Semibold = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeights.semiBold,
    color: MyColors.mainHeadingColor,
  );

  //Body text for pizza page
  static final body14px = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeights.regular,
    color: MyColors.bodyTextColor,
  );

//Body Text for cards
  static final body12px = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeights.regular,
    color: MyColors.bodyTextColor,
  );
  static final body12pxbold = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeights.bold,
    color: MyColors.bodyTextColor,
  );
  static final body12pxBlackbold = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeights.bold,
    color: MyColors.black,
  );
  static final body12pxdark = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeights.regular,
    color: MyColors.mainHeadingColor,
  );

  //For Subbody like Notification time
  static final subbody9px = GoogleFonts.poppins(
    fontSize: 9,
    fontWeight: FontWeights.regular,
    color: MyColors.bodyTextColor,
  );

  //Text for tab bars e.g. All, Pizzas, Sauces, etc.
  static final tabHeading = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeights.regular,
    color: MyColors.lightGray,
  );

//Text for buttons
  static final buttonText =
      GoogleFonts.poppins(fontSize: 14, color: MyColors.buttonTextColor);
  static final buttonTextDark =
      GoogleFonts.poppins(fontSize: 14, color: MyColors.mainHeadingColor);
  //Text for ID
  static final IDText = GoogleFonts.poppins(
    fontSize: 10,
    color: MyColors.lightGray,
    textStyle: const TextStyle(decoration: TextDecoration.underline),
  );

  static final clickableText = GoogleFonts.poppins(
    fontSize: 12,
    color: MyColors.primaryColor,
    decoration: TextDecoration.underline,
  );

  static final activeOrderCount = GoogleFonts.poppins(
    fontSize: 52,
    color: Colors.white,
    fontWeight: FontWeights.bold,
  );

  static final deliveredOrderCount = GoogleFonts.poppins(
    fontSize: 52,
    color: MyColors.black,
    fontWeight: FontWeights.bold,
  );

  static final activeOrder = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeights.semiBold,
    color: Colors.white,
  );

  static final deliveredOrder = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeights.semiBold,
    color: MyColors.darkGray,
  );

  static final ratingCount = GoogleFonts.poppins(
    fontSize: 23,
    fontWeight: FontWeights.bold,
    color: MyColors.primaryColor,
  );

  static final vendorHeading = GoogleFonts.poppins(
    fontSize: 17,
    fontWeight: FontWeights.regular,
    color: MyColors.black,
  );

  static final bottomSheetTitle = GoogleFonts.poppins(
    fontSize: 17,
    fontWeight: FontWeights.regular,
    color: MyColors.black,
  );

  static final bottomSheetText = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeights.bold,
    color: MyColors.black,
  );

  static final bottomSheetSubText = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeights.regular,
    color: MyColors.lightGray,
  );

  static final bottomSheetPrice = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeights.regular,
    color: MyColors.black,
  );

  static final H3Regular = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeights.regular,
    color: MyColors.mainHeadingColor,
  );

  static final trailingText =
      GoogleFonts.poppins(fontSize: 16, color: MyColors.darkGray);
}

extension FontWeights on FontWeight {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
