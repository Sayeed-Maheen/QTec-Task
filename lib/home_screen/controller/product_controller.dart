import 'package:get/get.dart';

import '../../models/all_products_model.dart';
import '../../services/repository/product_repository.dart';
import '../../widgets/app_snack_bar/app_snack_bar.dart';

/// Controller for managing product data, including fetching, pagination, and search filtering.
class ProductController extends GetxController {
  // Repository for fetching products from the data source
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

  @override
  void onInit() {
    super.onInit();
    // Fetch initial products on controller initialization
    fetchProducts();
    // Debounce search query changes to filter products efficiently
    debounce(
      searchQuery,
      (_) => filterProducts(),
      time: const Duration(milliseconds: 300),
    );
  }

  /// Fetches products from the repository, supporting initial load, infinite scroll, and refresh.
  /// - [isLoadMore]: If true, appends new products for infinite scroll.
  /// - [isRefresh]: If true, resets state and fetches fresh data for pull-to-refresh.
  Future<void> fetchProducts({
    bool isLoadMore = false,
    bool isRefresh = false,
  }) async {
    // Exit early if no more data is available for infinite scroll
    if (hasReachedEnd.value && isLoadMore) {
      print('No more data to fetch (hasReachedEnd is true)');
      return;
    }

    // Reset state for pull-to-refresh
    if (isRefresh) {
      print('Refreshing: Resetting state');
      currentPage.value = 1;
      productList.clear();
      filteredList.clear();
      hasReachedEnd.value = false;
    }

    // Set loading states
    if (isLoadMore) {
      isFetchingMore.value = true;
    } else {
      isLoading.value = true;
    }

    try {
      // Fetch products from the repository
      final response = await _repository.fetchAllProducts();
      if (response != null) {
        // Convert response to list of AllProduct objects
        final products =
            response
                .map((e) => AllProduct.fromJson(e))
                .toList()
                .cast<AllProduct>();

        print('Fetched ${products.length} products from repository');

        // Paginate the data
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

        // Check if we've reached the end of the data
        if (paginatedProducts.isEmpty ||
            paginatedProducts.length < itemsPerPage) {
          hasReachedEnd.value = true;
          print('Reached end of data: No more products to fetch');
        }

        // Update productList based on load type
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

        // Increment page for next fetch
        currentPage.value++;
        print('Updated productList length: ${productList.length}');

        // Reapply search filter to update filteredList
        filterProducts();
      } else {
        print('Repository returned null response');
        AppSnackBar.error("Failed to fetch products.");
      }
    } catch (e) {
      print('Error fetching products: $e');
      AppSnackBar.error("An error occurred while fetching products.");
    } finally {
      // Reset loading states
      if (isLoadMore) {
        isFetchingMore.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }

  /// Filters products based on the current search query.
  void filterProducts() {
    if (searchQuery.value.trim().isEmpty) {
      // Use spread operator to force reactive update
      filteredList.value = [...productList];
    } else {
      // Filter products by title matching the search query
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
}
