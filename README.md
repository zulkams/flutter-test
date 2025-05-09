# Flutter Test Project

## Project Overview

This is a Flutter application demonstrating basic functionalities such as product listing, product details, cart management, product search, and category filtering using the Fake Store API.

## Features

* Product List

  * Fetches product list from the Fake Store API.
  * Displays product name, price, and rating.
* Product Details

  * Navigates to product details page upon tapping a product.
  * Shows product name, description, price, image (zoomable using pinch), and rating.
* Cart Functionality

  * Add products to the cart.
  * Persist cart data using local storage (Hive).
  * Remove products from the cart.
* Product Search

  * Search products by name.
* Category Filtering

  * Filter products by category.

## Branching Strategy

* `main`: Base branch for the project.
* `develop`: For develop main branch
* `develop-zul`: For chores
* `product-list`: Feature branch for product list implementation.
* `product-details`: Feature branch for product details implementation.

## Getting Started
### Installation

1. Clone the repository:

   ```bash
   git clone <repository_url>
   cd flutter-test
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the application:

   ```bash
   flutter run
   ```

## Notes
* The is insignificant (0.2s-0.5s app hang) initial performance drop when doing Product Search for the first time on Debug mode due to Flutter Debug mode JIT. Won't happen on Profile/Release mode.
* Pinch gesture is used for image zoom on the product details page.
