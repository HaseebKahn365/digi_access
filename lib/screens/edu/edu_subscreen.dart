import 'package:cached_network_image/cached_network_image.dart';
import 'package:digi_access/models/edu_item.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' hide State, Center;

final notes = {
  50: {
    'color': 'Purple',
    'image': 'https://www.sbp.org.pk/banknotes/50/images/front.JPG',
  },
  100: {
    'color': 'Green',
    'image':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTf3PsRmCqILGGfs6Eps4xN-3HVKyMWgRNYgg&s',
  },
  500: {
    'color': 'Brown',
    'image': 'https://www.sbp.org.pk/finance/images/500new/500ovifront.jpg',
  },
  1000: {
    'color': 'Blue',
    'image': 'https://www.sbp.org.pk/finance/images/1000/big.JPG',
  },
  5000: {
    'color': 'Orange',
    'image': 'https://www.sbp.org.pk/images/notes/front-5000.jpg',
  },
};

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

  Map<int, int> _calculateNoteBreakdown(double price) {
    final notes = [5000, 1000, 500, 100, 50];
    final breakdown = <int, int>{};
    int remaining = price.toInt();

    for (final note in notes) {
      if (remaining >= note) {
        breakdown[note] = remaining ~/ note;
        remaining %= note;
      }
    }
    return breakdown;
  }

  void _showBigImage(String imageUrl) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder:
                  (context, url) =>
                      const Center(child: CircularProgressIndicator()),
              errorWidget:
                  (context, url, error) => const Icon(Icons.error, size: 100),
              fit: BoxFit.cover,
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F2F4F),

      //app bar with huge back button
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
                : SingleChildScrollView(
                  child: Column(
                    children:
                        _items.map((item) {
                          final breakdown = _calculateNoteBreakdown(item.price);
                          return Card(
                            margin: const EdgeInsets.all(12),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () => _showBigImage(item.imageUrl),
                                    child: CachedNetworkImage(
                                      imageUrl: item.imageUrl,
                                      placeholder:
                                          (context, url) =>
                                              const CircularProgressIndicator(),
                                      errorWidget:
                                          (context, url, error) =>
                                              const Icon(Icons.error),
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Total Price: Rs. ${item.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children:
                                        breakdown.entries.map((entry) {
                                          final noteValue = entry.key;
                                          final noteCount = entry.value;
                                          return GestureDetector(
                                            onTap: () {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    '$noteValue Rupee note tapped',
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl:
                                                      notes[noteValue]!['image']!,
                                                  placeholder:
                                                      (context, url) =>
                                                          const CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Icon(
                                                            Icons.error,
                                                          ),
                                                  height: 50,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  'x$noteCount',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
      ),
    );
  }
}
