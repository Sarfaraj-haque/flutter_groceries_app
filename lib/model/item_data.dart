import 'package:flutter/material.dart';

class GroceryItem {
  GroceryItem({required this.id, required this.name, required this.quantity, required this.category});

  final String id;
  final String name;
  final int quantity;
  final Category category;
}

enum Categories { vegetables, meat, dairy, carbs, fruit,sweets,spices,convenience,hygiene,other }

class Category {
  Category(this.color, this.name);

  final Color color;
  final String name;
}
