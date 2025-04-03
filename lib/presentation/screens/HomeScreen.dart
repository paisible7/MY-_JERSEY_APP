import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myjersey/presentation/screens/product_detail_screen.dart';
import '../../data/services/product_service.dart';

class HomeScreen extends StatelessWidget {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Maillots de Football")),
      body: FutureBuilder(
        future: _productService.getProducts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          final products = snapshot.data!;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(product: product);
            },
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final SupabaseClient supabase = Supabase.instance.client;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: product['images_url'][0],
            height: 150,
            fit: BoxFit.cover,
          ),
          Text(product['name'], style: TextStyle(fontWeight: FontWeight.bold)),
          Text(product['sizes'][0]),
          Text("${product['price']} Fc"),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
            ),
            icon: Icon(Icons.visibility),
          ),
        ],
      ),
    );
  }
}