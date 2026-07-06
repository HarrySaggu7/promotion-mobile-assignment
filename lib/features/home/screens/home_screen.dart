import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../products/providers/product_provider.dart';
import '../../products/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('EMA Store'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => productProvider.fetchProducts(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Guest 👋',
                style: AppTextStyles.heading2,
              ),

              const SizedBox(height: 4),

              Text(
                'Find your next great purchase',
                style: AppTextStyles.caption,
              ),

              const SizedBox(height: AppSpacing.lg),

              TextField(
                decoration: InputDecoration(
                  hintText: 'Search products',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(20),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '🔥 Summer Sale',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Up to 50% OFF Electronics',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              Text(
                'Categories',
                style: AppTextStyles.heading2,
              ),

              const SizedBox(height: AppSpacing.md),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _CategoryItem(
                    icon: Icons.phone_iphone,
                    title: 'Mobile',
                  ),
                  _CategoryItem(
                    icon: Icons.laptop,
                    title: 'Laptop',
                  ),
                  _CategoryItem(
                    icon: Icons.tv,
                    title: 'TV',
                  ),
                  _CategoryItem(
                    icon: Icons.headphones,
                    title: 'Audio',
                  ),
                ],
              ),

              const SizedBox(height: AppSpacing.xl),

              Text(
                'Featured Products',
                style: AppTextStyles.heading2,
              ),

              const SizedBox(height: AppSpacing.md),

              if (productProvider.isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (productProvider.error != null)
                Center(
                  child: Text(
                    productProvider.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              else
                GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: productProvider.products.length,
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
    childAspectRatio: 0.52,
  ),
  itemBuilder: (context, index) {
    return ProductCard(
      product: productProvider.products[index],
      onTap: () {
        // We'll implement navigation next
      },
      onAddToCart: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${productProvider.products[index].title} added to cart',
            ),
          ),
        );
      },
    );
  },
),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _CategoryItem({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: Icon(
            icon,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(title),
      ],
    );
  }
}