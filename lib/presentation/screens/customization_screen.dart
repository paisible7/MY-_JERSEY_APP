import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../providers/cart_provider.dart';
import 'package:image_editor/image_editor.dart';
import 'package:http/http.dart' as http;


class CustomizationScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const CustomizationScreen({required this.product});

  @override
  _CustomizationScreenState createState() => _CustomizationScreenState();
}

class _CustomizationScreenState extends State<CustomizationScreen> {
  String _customText = "";
  String _selectedFont = "Roboto";
  Color _selectedColor = Colors.white;

  @override
  void initState() {
    super.initState();
    final List<String> fontsAvailable = List<String>.from((widget.product['fonts_available'] as List).toSet());;

    if (fontsAvailable.isNotEmpty) {
      _selectedFont = fontsAvailable[0]; // ou une autre valeur par défaut
    }
  }

  Future<Uint8List> _generateCustomImage() async {
    try {
      final imageUrl = Supabase.instance.client.storage
          .from('products')
          .getPublicUrl(widget.product['images_url'][0]);
      final response = await http.get(Uri.parse(imageUrl));
      final Uint8List imageBytes = response.bodyBytes;

      final editorOption = ImageEditorOption();
      final textOption = AddTextOption();
      textOption.addText(
        EditorText(
          text: _customText,
          fontSizePx: 40,
          textColor: _selectedColor,
          fontName: _selectedFont,
          offset: const Offset(100, 100),
        ),
      );
      editorOption.addOption(textOption);

      final result = await ImageEditor.editImage(
        image: imageBytes,
        imageEditorOption: editorOption,
      );
      return result ?? Uint8List(0);
    } catch (e) {
      print("Erreur lors de la génération de l'image: $e");
      return Uint8List(0);
    }
  }


  @override
  Widget build(BuildContext context) {
    final List<String> fontsAvailable = List<String>.from((widget.product['fonts_available'] as List).toSet());;

    if (!fontsAvailable.contains(_selectedFont)) {
      _selectedFont = fontsAvailable.isNotEmpty ? fontsAvailable[0] : "Roboto"; // ou une autre valeur par défaut
    }
    return Scaffold(
      appBar: AppBar(title: Text("Personnalisez votre maillot")),
      body: Column(
        children: [
          FutureBuilder(
            future: _generateCustomImage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(child: Text("Erreur: ${snapshot.error}"));
              } else if (!snapshot.hasData) {
                return Center(child: Text("Aucune image disponible"));
              }
              return Image.memory(snapshot.data!);
            },
          ),
          TextField(
            onChanged: (value) => setState(() => _customText = value),
            decoration: InputDecoration(labelText: "Nom/Numéro"),
          ),
          DropdownButton<String>(
            value: _selectedFont,
            items: fontsAvailable.map((font) {
              return DropdownMenuItem(
                value: font,
                child: Text(_customText, style: TextStyle(
                  fontFamily: font,
                  fontSize: 30,
                  color: _selectedColor,
                )),
              );
            }).toList(),
            onChanged: (value) => setState(() => _selectedFont = value!),
          ),
          ElevatedButton(
            onPressed: () => _saveDesign(context),
            child: Text("Enregistrer la personnalisation"),
          ),
        ],
      ),
    );


  }



  void _saveDesign(BuildContext context) async {
    final imageBytes = await _generateCustomImage();
    if (imageBytes.isNotEmpty) {
      final filePath = 'custom_designs/${DateTime.now().millisecondsSinceEpoch}.png';
      await Supabase.instance.client.storage
          .from('designs')
          .uploadBinary(filePath, imageBytes, fileOptions: const FileOptions(contentType: 'image/png'));

      Provider.of<CartProvider>(context, listen: false).addToCart({
        ...widget.product,
        'custom_image': filePath,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erreur lors de l'enregistrement de la personnalisation.")));
    }
  }
}