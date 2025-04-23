import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/all_products_model.dart';
import '../../services/repository/product_repository.dart';
import '../../widgets/app_snack_bar/app_snack_bar.dart';

/// Controller for managing product data, scrolling, and search input.
class ProductController extends GetxController {
  // Repository for fetching products
  final ProductRepository _repository = ProductRepository();

  // Observables for reactive state management
  var isLoading = false.obs; // Tracks initial loading state
  var isFetchingMore = false.obs; // Tracks infinite scroll loading state
  var productList = <AllProduct>[].obs; // Full list of fetched products
  var filteredList = <AllProduct>[].obs; // Filtered list based on search query
  var searchQuery = ''.obs; // Current search query
  var currentPage = 1.obs; // Current pagination page
  var hasReachedEnd = false.obs; // Tracks if all data has been fetched
  final int itemsPerPage = 10; // Number of items per page

  // Controllers for UI interactions
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Fetch initial products
    fetchProducts();
    // Setup scroll listener for infinite scroll
    setupScrollListener();
    // Debounce search query changes for efficient filtering
    debounce(
      searchQuery,
      (_) => filterProducts(),
      time: const Duration(milliseconds: 200), // Reduced for responsiveness
    );
    // Sync searchController with initial searchQuery
    searchController.text = searchQuery.value;
  }

  /// Sets up the scroll listener for infinite scroll.
  void setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 50 &&
          !isFetchingMore.value &&
          !hasReachedEnd.value) {
        print('Scroll listener triggered: Loading more products...');
        fetchProducts(isLoadMore: true);
      }
    });
    print('Scroll listener initialized');
  }

  /// Updates search query from UI input.
  void updateSearchQuery(String value) {
    print('Search query updated: $value');
    searchQuery.value = value;
  }

  /// Fetches products from the repository, supporting initial load, infinite scroll, and refresh.
  Future<void> fetchProducts({
    bool isLoadMore = false,
    bool isRefresh = false,
  }) async {
    if (hasReachedEnd.value && isLoadMore) {
      print('No more data to fetch (hasReachedEnd is true)');
      return;
    }

    if (isRefresh) {
      print('Refreshing: Resetting state and clearing search');
      currentPage.value = 1;
      productList.clear();
      filteredList.clear();
      hasReachedEnd.value = false;
      searchController.clear();
      searchQuery.value = '';
    }

    if (isLoadMore) {
      isFetchingMore.value = true;
    } else {
      isLoading.value = true;
    }

    try {
      final response = await _repository.fetchAllProducts();
      if (response != null) {
        final products =
            response
                .map((e) => AllProduct.fromJson(e))
                .toList()
                .cast<AllProduct>();

        print('Fetched ${products.length} products from repository');

        final startIndex = (currentPage.value - 1) * itemsPerPage;
        final endIndex = startIndex + itemsPerPage;
        final paginatedProducts =
            products.length > startIndex
                ? products.sublist(
                  startIndex,
                  endIndex > products.length ? products.length : endIndex,
                )
                : <AllProduct>[];

        print(
          'Paginated ${paginatedProducts.length} products (page: ${currentPage.value}, start: $startIndex, end: $endIndex)',
        );

        if (paginatedProducts.isEmpty ||
            paginatedProducts.length < itemsPerPage) {
          hasReachedEnd.value = true;
          print('Reached end of data: No more products to fetch');
        }

        if (isLoadMore) {
          productList.addAll(paginatedProducts);
          print(
            'Added products: ${paginatedProducts.map((p) => p.title).toList()}',
          );
        } else {
          productList.value = paginatedProducts;
          print(
            'Set products: ${paginatedProducts.map((p) => p.title).toList()}',
          );
        }

        currentPage.value++;
        print('Updated productList length: ${productList.length}');

        filterProducts();
      } else {
        print('Repository returned null response');
        AppSnackBar.error("Failed to fetch products.");
      }
    } catch (e) {
      print('Error fetching products: $e');
      AppSnackBar.error("An error occurred while fetching products.");
    } finally {
      if (isLoadMore) {
        isFetchingMore.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }

  /// Filters products based on the search query.
  void filterProducts() {
    if (searchQuery.value.trim().isEmpty) {
      filteredList.value = [...productList]; // Force reactive update
    } else {
      filteredList.value =
          productList
              .where(
                (product) =>
                    product.title?.toLowerCase().contains(
                      searchQuery.value.toLowerCase(),
                    ) ??
                    false,
              )
              .toList();
    }
    print('Filtered list updated: ${filteredList.length} products');
  }

  @override
  void onClose() {
    // Clean up controllers to prevent memory leaks
    scrollController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
