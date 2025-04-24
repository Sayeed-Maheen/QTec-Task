# QTec Job Task App

This is a Flutter-based product management application that allows users to browse, search, and filter products. The app is built using the **Flutter** framework and leverages the **GetX** package for state management and routing.

## Features

- **Splash Screen**: Displays the app logo while initializing.
- **Product Listing**: Fetches and displays a list of products from a remote API.
- **Search Functionality**: Allows users to search for products by title.
- **Sorting**: Users can sort products by price (High to Low or Low to High).
- **Infinite Scrolling**: Automatically loads more products as the user scrolls.
- **Pull-to-Refresh**: Refreshes the product list.
- **Error Handling**: Displays error messages using custom snack bars.

## Project Structure

The project is organized as follows:

### `lib/`
- **`constants/`**: Contains app-wide constants like API URLs, colors, and icon paths.
- **`models/`**: Defines the data models used in the app.
- **`routes/`**: Manages app navigation and route bindings.
- **`screens/`**: Contains the UI screens and their respective controllers.
- **`services/`**: Handles API calls and data storage.
- **`widgets/`**: Reusable UI components like snack bars, text fields, and buttons.
- **`utils/`**: Utility functions for logging and responsive design.

## Key Components

### 1. **Splash Screen**
- **File**: `lib/screens/splash_screen/splash_screen.dart`
- Displays the app logo and navigates to the product screen after a delay.

### 2. **Product Screen**
- **File**: `lib/screens/product_screen/product_screen.dart`
- Displays a grid of products with search and filter options.
- Uses `ProductController` for managing product data and state.

### 3. **Product Controller**
- **File**: `lib/screens/product_screen/controller/product_controller.dart`
- Handles fetching, filtering, and sorting of products.
- Manages infinite scrolling and pull-to-refresh functionality.

### 4. **API Integration**
- **File**: `lib/services/api/api_get_services.dart`
- Uses the `Dio` package to fetch data from the API.
- Handles network errors and displays appropriate messages.

### 5. **Custom Widgets**
- **Snack Bars**: Displays error, success, or informational messages.
- **Product Card**: Displays product details like image, title, price, and rating.

## API Details

The app fetches product data from the [Fake Store API](https://fakestoreapi.com). The base URL is defined in `lib/constants/app_api_url.dart`.

## How It Works

1. **Splash Screen**: The app starts with a splash screen that transitions to the product screen.
2. **Product Listing**: The `ProductController` fetches products from the API and displays them in a grid.
3. **Search and Filter**: Users can search for products or sort them by price using the provided options.
4. **Infinite Scrolling**: As the user scrolls, more products are fetched and displayed.
5. **Error Handling**: If an error occurs (e.g., network issue), a custom snack bar displays the error message.

## Screenshots

<p float="left">
  <img src="https://github.com/user-attachments/assets/0b93a4d1-c407-480f-99bf-8e063e97cc7a" width="200" height="450"/>
  <img src="https://github.com/user-attachments/assets/87ef9dd2-5f67-48e9-89a6-8a6cc87ca1e3" width="200" height="450"/> 
  <img src="https://github.com/user-attachments/assets/2471b162-a886-460a-86a6-11fa6df30f3c" width="200" height="450"/>
  <img src="https://github.com/user-attachments/assets/dc57ecc0-a629-42bc-89c5-9310aef3e09c" width="200" height="450"/> 
</p>

## Installation

Clone the repository:
   
```bash
git clone https://github.com/Sayeed-Maheen/QTec-Task.git
```
Navigate to the project directory:
  ```bash
  cd QTec-Task
  ```
### Install dependencies:

```bash
flutter pub get
```
Run the app:

```bash
flutter run
```

### Dependencies
 - Flutter: Framework for building the app.
 - GetX: State management and routing.
 - Dio: HTTP client for API calls.


  
### License

This project is licensed under the MIT License.See the [LICENSE](https://choosealicense.com/licenses/mit/) file for details.

