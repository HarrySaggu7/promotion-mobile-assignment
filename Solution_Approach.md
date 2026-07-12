# Solution Approach

## 1. Objective

The objective of this application was to develop a modern Flutter shopping application that demonstrates clean architecture, scalable code organization, offline capability, and maintainable state management while delivering a responsive and user-friendly shopping experience.

The application supports product browsing, product details, shopping cart management, search functionality, store locator, and offline usage.

---

# 2. High Level Architecture

The application follows a layered architecture using the Repository Pattern.

```
                UI
                 │
        ┌────────┴────────┐
        │                 │
    Screens           Widgets
        │
        ▼
    Providers
        │
        ▼
  Repositories
     │       │
     ▼       ▼
 REST API   Hive
```

Each layer has a single responsibility, making the application easier to maintain and extend.

---

# 3. Project Structure

A feature-based folder structure has been used.

```
lib
│
├── core
│   ├── constants
│   ├── network
│   └── storage
│
├── features
│   ├── auth
│   ├── cart
│   ├── dashboard
│   ├── home
│   ├── products
│   └── store
│
└── router
```

Benefits:

- Better separation of concerns
- Easier navigation
- Independent feature development
- Improved scalability

---

# 4. State Management

Provider was selected for state management.

Reasons:

- Lightweight
- Official Flutter recommendation for medium-sized applications
- Simple learning curve
- Minimal boilerplate
- Easy integration with ChangeNotifier

Separate providers are maintained for different business domains.

Examples:

- ProductProvider
- CartProvider

This avoids unnecessary coupling between different modules.

---

# 5. Repository Pattern

The Repository Pattern is used to isolate data access from the presentation layer.

```
Home Screen
      │
      ▼
Product Provider
      │
      ▼
Product Repository
      │
 ┌────┴────┐
 │         │
API      Hive Cache
```

Advantages:

- UI remains independent of the data source.
- Switching between API and local cache becomes easier.
- Better testability.
- Improved maintainability.

---

# 6. Offline Strategy

Offline capability is implemented using Hive.

### Product Flow

```
Launch App
      │
      ▼
Call Repository
      │
      ▼
Internet Available?
      │
 ┌────┴─────┐
 │          │
Yes         No
 │          │
 ▼          ▼
API       Hive
 │          │
 └────┬─────┘
      ▼
UI
```

If API data is available, products are downloaded and stored in Hive.

If internet is unavailable, products are loaded from Hive without impacting user experience.

---

# 7. Cart Persistence

Shopping cart data is persisted using Hive.

Only lightweight information is stored:

```
productId
quantity
```

During application startup:

1. Products are loaded.
2. Cart data is restored.
3. Product IDs are mapped to ProductModel objects.
4. Cart UI is reconstructed.

This avoids duplication of product information.

---

# 8. Image Loading Strategy

Product images are loaded using CachedNetworkImage.

Benefits:

- Automatic disk caching
- Improved scrolling performance
- Reduced network requests
- Better offline experience

---

# 9. Search Strategy

Search is implemented locally.

```
All Products

↓

Filter by Title

↓

Filtered Products
```

Advantages:

- Instant results
- No API calls
- Works offline
- Better user experience

---

# 10. Navigation

Navigation is implemented using GoRouter.

Routes include:

- Login
- Dashboard
- Product Details
- Cart
- Store Locator

Benefits:

- Declarative routing
- Scalable route management
- Cleaner navigation logic

---

# 11. Error Handling

Network exceptions are handled inside the Repository layer.

Examples:

- No internet connection
- Timeout
- Server error
- Unknown exception

This prevents networking logic from leaking into the UI.

---

# 12. Design Principles

The application follows:

- Separation of Concerns
- Single Responsibility Principle
- Feature-Based Architecture
- Reusable Components
- Clean UI Layer

Examples of reusable widgets:

- ProductCard
- CartItemCard

---

# 13. Performance Optimizations

The following optimizations have been implemented:

- Local Hive caching
- Image caching
- Lazy GridView rendering
- Provider-based selective rebuilds
- Repository abstraction
- Search without API calls

---

# 14. Future Enhancements

The application can be enhanced further with:

- User authentication
- Wishlist
- Payment gateway
- Push notifications
- Product pagination
- Unit testing
- Widget testing
- Dependency Injection
- Dark theme
- Analytics

---

# 15. Conclusion

The implemented solution demonstrates a scalable Flutter architecture suitable for medium-sized applications.

By combining Provider, Repository Pattern, Hive, GoRouter, and CachedNetworkImage, the application remains modular, maintainable, and capable of providing a smooth online and offline user experience.