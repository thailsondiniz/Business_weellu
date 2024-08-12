import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SubCategoryItem {
  final String? idSpecifc;
  final String? nome;
  final IconData? iconSub;
  final Color? color;

  SubCategoryItem({
    this.idSpecifc,
    this.nome,
    this.iconSub,
    this.color,
  });

  factory SubCategoryItem.fromJson(Map<String, dynamic> json) {
    return SubCategoryItem(
      idSpecifc: json['idSpecifc'],
      nome: json['nome'],
      iconSub: _parseSubIconData(json['iconSubCategoria']),
      color: parseSubIconColor(json['color']),
    );
  }

  static Color parseSubIconColor(String colorStr) {
    return Color(int.parse(colorStr));
  }

  static IconData? _parseSubIconData(String? iconName) {
    if (iconName == null) return null;
    switch (iconName) {
      case 'DrinkIcon':
        return PhosphorIcons.wine();
      case 'SnackIcon':
        return PhosphorIcons.cookie();
      case 'DinnerIcon':
        return PhosphorIcons.forkKnife();
      case 'LunchIcon':
        return PhosphorIcons.pizza();
      case 'CoffeIcon':
        return PhosphorIcons.coffee();
      default:
        return PhosphorIcons.question();
    }
  }
}
