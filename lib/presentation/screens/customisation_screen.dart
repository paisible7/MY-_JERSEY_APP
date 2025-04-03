import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CustomizationScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  CustomizationScreen({required this.product});

  @override
  _CustomizationScreenState createState() => _CustomizationScreenState();
}

class _CustomizationScreenState extends State<CustomizationScreen> {
  String _customText = "";
  String _selectedFont = "Arial";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personnalisation")),
      body: Column(
        children: [
          // Aperçu du maillot avec texte
          Stack(
            alignment: Alignment.center,
            children: [
              CachedNetworkImage(imageUrl: widget.product['images_url'][0]),
              Text(
                _customText,
                style: GoogleFonts.getFont(
                  _selectedFont,
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          // Champ de saisie
          TextField(
            onChanged: (value) => setState(() => _customText = value),
            decoration: InputDecoration(labelText: "Texte personnalisé"),
          ),
          // Sélection de police
          DropdownButton<String>(
            value: _selectedFont,
            items: widget.product['fonts_available'].map<DropdownMenuItem<String>>((font) {
              return DropdownMenuItem(value: font, child: Text(font));
            }).toList(),
            onChanged: (value) => setState(() => _selectedFont = value!),
          ),
          // Bouton "Ajouter au panier"
          ElevatedButton(
            onPressed: () => _addToCart(context),
            child: Text("Ajouter au panier"),
          ),
        ],
      ),
    );
  }

  void _addToCart(BuildContext context) {
    final cartItem = {
      'product_id': widget.product['id'],
      'custom_text': _customText,
      'font': _selectedFont,
      'price': widget.product['price'],
    };

    // Utilisez Provider ou un service pour gérer le panier
    Provider.of<CartProvider>(context, listen: false).addToCart(cartItem);
    Navigator.pop(context);
  }
}