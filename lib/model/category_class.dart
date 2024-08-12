import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ItemCategory {
  final String? nome;
  final IconData? icon;
  final int? color;

  ItemCategory({
    this.icon,
    this.nome,
    this.color,
  });

  factory ItemCategory.fromJson(Map<String, dynamic> json) {
    return ItemCategory(
      nome: json['nome'],
      icon: _parseIconData(json['icon']),
      color: parseIconColor(json['color']),
    );
  }

  static int parseIconColor(color) {
    var result = int.parse(color);
    return result;
  }

  static IconData? _parseIconData(String? iconName) {
    if (iconName == null) return null;
    switch (iconName) {
      case 'FoodIcon':
        return PhosphorIcons.hamburger();
      case 'HomeIcon':
        return PhosphorIcons.armchair();
      case 'VehiclesIcon':
        return PhosphorIcons.motorcycle();
      case 'EletronicsIcon':
        return PhosphorIcons.androidLogo();
      case 'ClothesIcon':
        return PhosphorIcons.coatHanger();
      case 'TravelIcon':
        return PhosphorIcons.airplane();
      case 'SportsIcon':
        return PhosphorIcons.basketball();
      case 'HealthIcon':
        return PhosphorIcons.heartbeat();
      default:
        return null;
    }
  }
}
