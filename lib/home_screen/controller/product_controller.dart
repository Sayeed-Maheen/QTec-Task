import 'package:get/get.dart';

import '../../models/all_products_model.dart';
import '../../services/repository/product_repository.dart';
import '../../widgets/app_snack_bar/app_snack_bar.dart';

class ProductController extends GetxController {
  final ProductRepository _repository = ProductRepository();

  var isLoading = false.obs;
  var isFetchingMore = false.obs;
  var productList = <AllProduct>[].obs;
  var currentPage = 1.obs;
  final int itemsPerPage = 10;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts({bool isLoadMore = false}) async {
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

        // Paginate the data
        final startIndex = (currentPage.value - 1) * itemsPerPage;
        final endIndex = startIndex + itemsPerPage;
        final paginatedProducts = products.sublist(
          startIndex,
          endIndex > products.length ? products.length : endIndex,
        );

        if (isLoadMore) {
          productList.addAll(paginatedProducts);
        } else {
          productList.value = paginatedProducts;
        }

        currentPage.value++;
      } else {
        AppSnackBar.error("Failed to fetch products.");
      }
    } catch (e) {
      AppSnackBar.error("An error occurred while fetching products.");
    } finally {
      if (isLoadMore) {
        isFetchingMore.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }
}
