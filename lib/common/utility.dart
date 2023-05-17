import 'package:flutter/material.dart';

const defaultPhysics = BouncingScrollPhysics();

extension PriceLable on int {
  String get withPriceLabel => "$this تومان";
}
