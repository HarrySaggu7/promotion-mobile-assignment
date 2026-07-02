import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("EMA Store"),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.shopping_cart_outlined),
          )
        ],
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(AppSpacing.md),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              "Hello, Guest 👋",
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: 4),

            Text(
              "Find your next great purchase",
              style: AppTextStyles.caption,
            ),

            const SizedBox(height: 24),

            TextField(

              decoration: InputDecoration(

                hintText: "Search products",

                prefixIcon: const Icon(Icons.search),

                filled: true,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 24),

            Container(

              height: 150,

              decoration: BoxDecoration(

                color: AppColors.primary,

                borderRadius: BorderRadius.circular(20),

              ),

              child: const Padding(

                padding: EdgeInsets.all(20),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    Text(
                      "🔥 Summer Sale",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      "Up to 50% OFF Electronics",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              "Categories",
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: 16),

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                _category(Icons.phone_iphone, "Mobile"),

                _category(Icons.laptop, "Laptop"),

                _category(Icons.tv, "TV"),

                _category(Icons.headphones, "Audio"),

              ],
            ),

            const SizedBox(height: 30),

            Text(
              "Featured Products",
              style: AppTextStyles.heading2,
            ),

            const SizedBox(height: 16),

            _productCard(),

            const SizedBox(height: 16),

            _productCard(),

          ],
        ),
      ),
    );
  }

  Widget _category(IconData icon, String text) {
    return Column(
      children: [

        CircleAvatar(
          radius: 28,
          child: Icon(icon),
        ),

        const SizedBox(height: 8),

        Text(text),

      ],
    );
  }

  Widget _productCard() {
    return Card(

      elevation: 2,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      child: ListTile(

        leading: const Icon(
          Icons.shopping_bag,
          size: 40,
        ),

        title: const Text("Samsung Smart TV"),

        subtitle: const Text("₹45,999"),

        trailing: ElevatedButton(

          onPressed: () {},

          child: const Text("Add"),

        ),
      ),
    );
  }
}