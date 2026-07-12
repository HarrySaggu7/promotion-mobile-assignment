# EMA Store - Flutter Shopping Application

## Overview

EMA Store is a Flutter-based shopping application developed as part of the EMA promotion assignment. The application demonstrates modern Flutter development practices including clean architecture, state management, offline support, and responsive UI.

The application allows users to browse products, search products, view product details, manage a shopping cart, locate nearby stores, and continue using the application even when offline.

---

## Features

### Authentication

- Login screen
- Continue as Guest

### Home

- Product listing
- Search products
- Promotional banner
- Category section
- Pull to refresh

### Product

- Product details
- Rating information
- Add to Cart

### Shopping Cart

- Add products
- Increase / decrease quantity
- Remove products
- Cart total
- Persistent cart storage

### Store Locator

- Store listing
- Navigation to stores

### Offline Support

- Product caching using Hive
- Cart persistence using Hive
- Cached product images
- Offline product browsing
- Offline search

---

## Tech Stack

- Flutter
- Provider
- GoRouter
- Dio
- Hive
- Cached Network Image

---

## Architecture

The application follows a feature-based architecture combined with Repository Pattern.

```
Presentation
│
├── Screens
├── Widgets
└── Providers
        │
        ▼
Repositories
        │
        ▼
API / Local Storage
```

---

## Folder Structure

```
lib/
│
├── core/
│   ├── constants/
│   ├── network/
│   └── storage/
│
├── features/
│   ├── auth/
│   ├── cart/
│   ├── dashboard/
│   ├── home/
│   ├── products/
│   └── store/
│
└── router/
```

---

## State Management

The application uses **Provider** for state management.

Providers include:

- ProductProvider
- CartProvider

---

## Offline Strategy

Products are downloaded from the API and cached locally using Hive.

Application Flow:

```
API
 │
 ▼
Hive Cache
 │
 ▼
Repository
 │
 ▼
Provider
 │
 ▼
UI
```

If internet connectivity is unavailable, products are automatically loaded from Hive.

Shopping cart information is also persisted locally.

---

## API

Products are fetched from:

https://fakestoreapi.com/products

---

## How to Run

Clone repository

```bash
git clone <repository-url>
```

Install dependencies

```bash
flutter pub get
```

Run

```bash
flutter run
```

---

## Packages Used

| Package | Purpose |
|----------|----------|
| provider | State management |
| dio | Network requests |
| hive | Local storage |
| go_router | Navigation |
| cached_network_image | Image caching |

---

## Future Improvements

- Unit Testing
- Widget Testing
- Dependency Injection
- Pagination
- Wishlist
- Payment Integration
- User Authentication
- Dark Theme
- Push Notifications

---

## Developed By

Harpreet Singh Saggu

Flutter Promotion Assignment