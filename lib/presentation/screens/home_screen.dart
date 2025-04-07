import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myjersey/presentation/screens/product_detail_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/services/product_service.dart';

class HomeScreen extends StatelessWidget {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Jersey")),
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
    // Générer l'URL complète depuis Supabase Storage
    final imageUrl = supabase.storage
        .from('products')  // Nom de votre bucket
        .getPublicUrl(product['images_url'][0]);  // Chemin du fichier stocké

    return Card(
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            height: 150,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey[300],
              height: 150,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(product['name'],
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Tailles: ${product['sizes'].join(', ')}"),
                SizedBox(height: 4),
                Text("${product['price']} Fc",
                    style: TextStyle(color: Colors.green)),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(product: product)),
            ),
            icon: Icon(Icons.visibility, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}