import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state_management/providers/cart_provider.dart';
import '../consts.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _buildUI(context),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "Products",
        style: TextStyle(
          fontSize: 24, // Font size for the title
          fontWeight: FontWeight.bold, // Bold text
          color: Colors.white, // Title color
        ),
      ),
      centerTitle: true, // Center the title
      backgroundColor: Colors.teal, // Same background color as CartPage
      elevation: 4.0, // Shadow under the AppBar
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, "/cart");
          },
          icon: const Icon(
            Icons.shopping_cart,
            color: Colors.white, // Icon color matches title
          ),
          tooltip: 'Go to Cart', // Tooltip for better accessibility
        ),
      ],
    );
  }

  Widget _buildUI(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    return ListView.builder(
      itemCount: PRODUCTS.length,
      itemBuilder: (context, index) {
        Product product = PRODUCTS[index];
        return ListTile(
          leading: Container(
            height: 25,
            width: 25,
            color: product.color,
          ),
          title: Text(
            product.name,
          ),
          trailing: Checkbox(
            value: cartProvider.items.contains(product),
            onChanged: (value) {
              if (value == true) {
                cartProvider.add(product);
              } else {
                cartProvider.remove(product);
              }
            },
          ),
        );
      },
    );
  }
}
