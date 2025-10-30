import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category {
  final int? id;
  final String name;
  final String iconName;
  final String colorHex;
  final String type; // 'income' or 'expense'

  Category({
    this.id,
    required this.name,
    required this.iconName,
    required this.colorHex,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iconName': iconName,
      'colorHex': colorHex,
      'type': type,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      iconName: map['iconName'],
      colorHex: map['colorHex'],
      type: map['type'],
    );
  }

  IconData get icon {
    switch (iconName) {
      case 'food':
        return FontAwesomeIcons.utensils;
      case 'transport':
        return FontAwesomeIcons.car;
      case 'shopping':
        return FontAwesomeIcons.bagShopping;
      case 'entertainment':
        return FontAwesomeIcons.gamepad;
      case 'health':
        return FontAwesomeIcons.heartPulse;
      case 'education':
        return FontAwesomeIcons.graduationCap;
      case 'bills':
        return FontAwesomeIcons.fileInvoiceDollar;
      case 'salary':
        return FontAwesomeIcons.moneyBillWave;
      case 'freelance':
        return FontAwesomeIcons.laptop;
      case 'investment':
        return FontAwesomeIcons.chartLine;
      case 'gift':
        return FontAwesomeIcons.gift;
      case 'other':
        return FontAwesomeIcons.ellipsis;
      default:
        return FontAwesomeIcons.circle;
    }
  }

  Color get color {
    return Color(int.parse(colorHex.replaceFirst('#', '0xFF')));
  }
}

class DefaultCategories {
  static List<Category> get expenseCategories => [
    Category(
      name: 'Food & Dining',
      iconName: 'food',
      colorHex: '#FF6B6B',
      type: 'expense',
    ),
    Category(
      name: 'Transportation',
      iconName: 'transport',
      colorHex: '#4ECDC4',
      type: 'expense',
    ),
    Category(
      name: 'Shopping',
      iconName: 'shopping',
      colorHex: '#45B7D1',
      type: 'expense',
    ),
    Category(
      name: 'Entertainment',
      iconName: 'entertainment',
      colorHex: '#96CEB4',
      type: 'expense',
    ),
    Category(
      name: 'Health & Fitness',
      iconName: 'health',
      colorHex: '#FFEAA7',
      type: 'expense',
    ),
    Category(
      name: 'Education',
      iconName: 'education',
      colorHex: '#DDA0DD',
      type: 'expense',
    ),
    Category(
      name: 'Bills & Utilities',
      iconName: 'bills',
      colorHex: '#98D8C8',
      type: 'expense',
    ),
    Category(
      name: 'Other',
      iconName: 'other',
      colorHex: '#F7DC6F',
      type: 'expense',
    ),
  ];

  static List<Category> get incomeCategories => [
    Category(
      name: 'Salary',
      iconName: 'salary',
      colorHex: '#2ECC71',
      type: 'income',
    ),
    Category(
      name: 'Freelance',
      iconName: 'freelance',
      colorHex: '#3498DB',
      type: 'income',
    ),
    Category(
      name: 'Investment',
      iconName: 'investment',
      colorHex: '#9B59B6',
      type: 'income',
    ),
    Category(
      name: 'Gift',
      iconName: 'gift',
      colorHex: '#E74C3C',
      type: 'income',
    ),
    Category(
      name: 'Other',
      iconName: 'other',
      colorHex: '#F39C12',
      type: 'income',
    ),
  ];
}
