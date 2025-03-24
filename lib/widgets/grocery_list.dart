import 'package:flutter/material.dart';
import 'package:flutter_groceries_app/data/dummy_data.dart';
import 'package:flutter_groceries_app/widgets/new_Item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  void _addItem() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => NewItem()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Groceries"),
        actions: [IconButton(onPressed: _addItem, icon: Icon(Icons.add))],
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          final item = groceryItems[index];
          return ListTile(
            title: Text(item.name),
            leading: Container(
              width: 24,
              height: 24,
              color: item.category.color,
            ),
            trailing: Text(item.quantity.toString()),
          );
        },
        itemCount: groceryItems.length,
      ),
    );
  }
}
