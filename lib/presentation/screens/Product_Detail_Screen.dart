import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Customization_Screen.dart';



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
    final List<String> sizes = List<String>.from(widget.product['sizes'] as List);
    return Scaffold(
      appBar: AppBar(title: Text(widget.product['name'])),
      body: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: Supabase.instance.client.storage
                  .from('products')
                  .getPublicUrl(widget.product['images_url'][0]),
              fit: BoxFit.contain,
            ),
          ),
          DropdownButton<String>(
            value: _selectedSize,
            items: sizes.map<DropdownMenuItem<String>>((String size) {
              return DropdownMenuItem<String>(
                value: size,
                child: Text(size),
              );
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