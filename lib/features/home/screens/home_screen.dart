import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../products/providers/product_provider.dart';
import '../../products/widgets/product_card.dart';
import '../../cart/providers/cart_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
  final productProvider = context.read<ProductProvider>();
  final cartProvider = context.read<CartProvider>();

  if (!productProvider.hasProducts) {
    await productProvider.fetchProducts();
  }

  cartProvider.restoreCart(
    productProvider.products,
  );
});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
  title: const Text('EMA Store'),
  actions: [
    IconButton(
      tooltip: 'Store Locator',
      onPressed: () {
        context.push('/stores');
      },
      icon: const Icon(Icons.location_on_outlined),
    ),

    Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            tooltip: 'Shopping Cart',
            onPressed: () {
              context.push('/cart');
            },
            icon: Badge(
              backgroundColor: Colors.red,
              textColor: Colors.white,
              isLabelVisible: cartProvider.totalItems > 0,
              label: Text(
                cartProvider.totalItems.toString(),
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
          ),
        );
      },
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

              /// SEARCH BAR
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  productProvider.searchProducts(value);
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: 'Search products',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            productProvider.clearSearch();
                            setState(() {});
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              /// BANNER
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

              /// CATEGORIES
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

              /// PRODUCTS
              Text(
                'Featured Products',
                style: AppTextStyles.heading2,
              ),

              const SizedBox(height: AppSpacing.md),

              if (productProvider.isLoading)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(
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
              else if (productProvider.products.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 60),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 70,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Try another search keyword.',
                        ),
                      ],
                    ),
                  ),
                )
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: productProvider.products.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.52,
                  ),
                  itemBuilder: (context, index) {
                    final product = productProvider.products[index];

                    return ProductCard(
  product: product,
  onTap: () {
    context.push(
      '/product',
      extra: product,
    );
  },
  onAddToCart: () {
    context.read<CartProvider>().addToCart(product);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(
          '${product.title} added to cart',
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
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
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