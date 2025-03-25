import 'package:flutter/material.dart';
import 'package:flutter_groceries_app/model/item_data.dart';
import 'package:flutter_groceries_app/widgets/new_Item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItem = [];

  void _addItem() async {
    var newItem = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => NewItem()));
    if (newItem == null) return null;
    setState(() {
      _groceryItem.add(newItem!);
    });
  }

  void _removedItem(GroceryItem item) {
    setState(() {
      _groceryItem.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text("No items Added yet"),
    );

    if (_groceryItem.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItem.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            key: ValueKey(_groceryItem[index].id),
            onDismissed: (direction) {
              _removedItem(_groceryItem[index]);
            },
            child: ListTile(
              title: Text(_groceryItem[index].name),
              leading: Container(
                width: 24,
                height: 24,
                color: _groceryItem[index].category.color,
              ),
              trailing: Text(_groceryItem[index].quantity.toString()),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Groceries"),
        actions: [IconButton(onPressed: _addItem, icon: Icon(Icons.add))],
      ),
      body: content,
    );
  }
}
