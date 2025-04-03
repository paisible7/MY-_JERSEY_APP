import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'customisation_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  ProductDetailScreen({required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String _selectedSize = 'M';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product['name'])),
      body: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: widget.product['images_url'][0],
              fit: BoxFit.contain,
            ),
          ),
          DropdownButton<String>(
            value: _selectedSize,
            items: widget.product['sizes'].map<DropdownMenuItem<String>>((size) {
              return DropdownMenuItem(value: size, child: Text(size));
            }).toList(),
            onChanged: (value) => setState(() => _selectedSize = value!),
          ),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CustomizationScreen(product: widget.product)),
            ),
            child: Text("Personnaliser"),
          ),
        ],
      ),
    );
  }
}