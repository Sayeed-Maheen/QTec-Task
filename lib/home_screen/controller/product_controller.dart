import 'package:get/get.dart';

import '../../models/all_products_model.dart';
import '../../services/repository/product_repository.dart';
import '../../widgets/app_snack_bar/app_snack_bar.dart';

class ProductController extends GetxController {
  final ProductRepository _repository = ProductRepository();

  var isLoading = false.obs;
  var productList = <AllProduct>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    isLoading.value = true;
    try {
      final response = await _repository.fetchAllProducts();
      if (response != null) {
        productList.value =
            response.map((e) => AllProduct.fromJson(e)).toList();
        print("Mapped Products: ${productList.length}"); // Debug log
      } else {
        AppSnackBar.error("Failed to fetch products.");
      }
    } catch (e) {
      AppSnackBar.error("An error occurred while fetching products.");
    } finally {
      isLoading.value = false;
    }
  }
}
