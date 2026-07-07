import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        centerTitle: true,
      ),
      body: cartProvider.items.isEmpty
          ? const _EmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartProvider.items.length,
                    itemBuilder: (context, index) {
                      final item = cartProvider.items[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Image.network(
                                item.product.image,
                                width: 70,
                                height: 70,
                                fit: BoxFit.contain,
                              ),

                              const SizedBox(width: 16),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 6),

                                    Text(
                                      "\$${item.product.price.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 12),

                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            cartProvider.decreaseQuantity(
                                              item.product,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                          ),
                                        ),

                                        Text(
                                          item.quantity.toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),

                                        IconButton(
                                          onPressed: () {
                                            cartProvider.increaseQuantity(
                                              item.product,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              IconButton(
                                onPressed: () {
                                  cartProvider.removeFromCart(item.product);
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "\$${cartProvider.totalAmount.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Checkout coming soon 🚀",
                                ),
                              ),
                            );
                          },
                          child: const Text("Checkout"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            "Your cart is empty",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Add some products to continue shopping.",
          ),
        ],
      ),
    );
  }
}