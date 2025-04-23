import '../../constants/app_api_url.dart';
import '../api/api_get_services.dart';

class ProductRepository {
  final ApiGetServices _apiGetServices = ApiGetServices();

  Future<List<dynamic>?> fetchAllProducts() async {
    try {
      final response = await _apiGetServices.apiGetServices(AppApiUrl.product);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
