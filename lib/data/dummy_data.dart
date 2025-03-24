import 'package:flutter_groceries_app/data/categories.dart';
import 'package:flutter_groceries_app/model/item_data.dart';

final groceryItems = [

  GroceryItem(id: 'a',quantity: 1,name: "Milk",category: categories[Categories.dairy]!),
  GroceryItem(id: 'b',quantity: 5,name: "Bananas",category: categories[Categories.fruit]!),
  GroceryItem(id: 'c',quantity: 1,name: "Beef Steak",category: categories[Categories.meat]!),

  ];
