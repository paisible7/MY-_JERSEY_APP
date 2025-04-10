import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../providers/Cart_Provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Panier")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return ListTile(
                  leading: CachedNetworkImage(imageUrl: item['image_url']),
                  title: Text(item['custom_text']),
                  subtitle: Text("Police: ${item['font']}"),
                  trailing: Text("${item['price']} Fc"),
                  onTap: () => cart.removeFromCart(index),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Total: ${cart.total} Fc", style: TextStyle(fontSize: 20)),
          ),
          ElevatedButton(
            onPressed: () => _placeOrder(context),
            child: Text("Passer la commande"),
          ),
        ],
      ),
    );
  }

  void _placeOrder(BuildContext context) async {
    final user = Supabase.instance.client.auth.currentUser;
    final cart = Provider.of<CartProvider>(context, listen: false);

    final order = {
      'user_id': user!.id,
      'items': cart.items,
      'total': cart.total,
      'status': 'pending',
    };

    await Supabase.instance.client.from('orders').insert(order);
    cart.clearCart();
    Navigator.pushNamed(context, '/order_confirmation');
  }
}