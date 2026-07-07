import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../models/product_model.dart';
import 'package:provider/provider.dart';
import '../../cart/providers/cart_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'product_${product.id}',
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20),
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              product.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                const SizedBox(width: 6),
                Text(
                  '${product.rating.rate}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '(${product.rating.count} Reviews)',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Chip(
              label: Text(product.category.toUpperCase()),
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            ),

            const SizedBox(height: 20),

            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              product.description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: FilledButton.icon(
                onPressed: () {
  context.read<CartProvider>().addToCart(product);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${product.title} added to cart'),
      duration: const Duration(seconds: 2),
    ),
  );
},
                icon: const Icon(Icons.shopping_cart),
                label: const Text(
                  'Add To Cart',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}