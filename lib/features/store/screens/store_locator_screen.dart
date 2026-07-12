import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../models/store_model.dart';
import '../widgets/store_card.dart';

class StoreLocatorScreen extends StatelessWidget {
  const StoreLocatorScreen({super.key});

  static const List<StoreModel> stores = [
    StoreModel(
      name: 'EMA Store Chandigarh',
      address: 'Sector 17 Plaza, Chandigarh',
      timings: '9:00 AM - 9:00 PM',
      latitude: 30.741482,
      longitude: 76.768066,
    ),
    StoreModel(
      name: 'EMA Store Mohali',
      address: 'Phase 8, Mohali',
      timings: '10:00 AM - 8:00 PM',
      latitude: 30.704649,
      longitude: 76.717873,
    ),
    StoreModel(
      name: 'EMA Store Delhi',
      address: 'Connaught Place, New Delhi',
      timings: '10:00 AM - 10:00 PM',
      latitude: 28.631451,
      longitude: 77.216667,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Locator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: ListView.builder(
          itemCount: stores.length,
          itemBuilder: (context, index) {
            return StoreCard(
              store: stores[index],
            );
          },
        ),
      ),
    );
  }
}