import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_access/models/edu_item.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' hide State, Center;

class ShoppingPrac extends StatefulWidget {
  const ShoppingPrac({super.key});

  @override
  State<ShoppingPrac> createState() => ShoppingPracState();
}

class ShoppingPracState extends State<ShoppingPrac> {
  late Db _db;
  bool _isLoading = true;
  List<EduItem> _items = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _connectToMongoDB();
  }

  //the database name is digiaccessdb
  Future<void> _connectToMongoDB() async {
    try {
      _db = await Db.create(
        'mongodb+srv://haseebkahn365:n5on01PgsFBy9FDn@cluster0.b22s5fa.mongodb.net/digiaccessdb',
      );
      await _db.open();
      await _fetchItems();
    } catch (e) {
      setState(() {
        _error = 'Failed to connect to database: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchItems() async {
    try {
      final collection = _db.collection('edu_store');
      final items = await collection.find().toList();
      setState(() {
        log('Fetched items: $items');
        _items = items.map((item) => EduItem.fromMap(item)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to fetch items: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F2F4F),
      body: SafeArea(
        child:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                ? Center(
                  child: Text(
                    _error!,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
                : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    item.imageUrl,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Rs. ${item.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
