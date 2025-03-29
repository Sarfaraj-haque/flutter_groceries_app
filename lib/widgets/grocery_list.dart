import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_groceries_app/model/item_data.dart';
import 'package:flutter_groceries_app/widgets/new_Item.dart';
import 'package:http/http.dart' as http;

import '../data/categories.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItem = [];
  var isLoading = true;
  String? _error;

  @override
  void initState() {
    _loadingData();
    super.initState();
  }


  void _loadingData() async {
    final url = Uri.https(
        "flutter-pr-24217-default-rtdb.firebaseio.com", "shopping-list.json");
    try{
    final response = await http.get(url);
    if (response.statusCode >= 400) {
      setState(() {
        _error = "Failed to load items";
      });
      return;
    }
    final Map<String, dynamic> listData = jsonDecode(response.body);
    final List<GroceryItem> itemData = [];
    for (final item in listData.entries) {
      final catGory = categories.entries
          .firstWhere((catItem) => catItem.value.name == item.value['category'])
          .value;
      itemData.add(
        GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: catGory),
      );
    }
    setState(() {
      _groceryItem = itemData;
      isLoading = false;
    });
  }catch(e){
      setState(() {
        _error = "Something went wrong";
      });
    }
  }

  void _addItem() async {
    final newItem = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => NewItem()));
    if (newItem == null) return;

    setState(() {
      _groceryItem.add(newItem);
    });
  }

  void _removedItem(GroceryItem item) async {
    final index = _groceryItem.indexOf(item);
    setState(() {
      _groceryItem.remove(item);
    });

    final url = Uri.https(
        "flutter-pr-24217-default-rtdb.firebaseio.com", "shopping-list.json");
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      setState(() {
        _groceryItem.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text("No items Added yet"),
    );
    if (isLoading) {
      content = Center(
        child: CircularProgressIndicator(),
      );
    }

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

    if (_error != null) {
      content = Center(
        child: Text(_error!),
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
