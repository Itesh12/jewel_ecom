import '../providers/api_client.dart';
import '../providers/api_endpoints.dart';
import '../models/category_model.dart';

class HomeRepository {
  final ApiClient _apiClient;

  HomeRepository(this._apiClient);

  Future<List<CategoryModel>> getCategories({
    required int branchId,
    bool isActive = true,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.categoryList,
      data: {"branchId": branchId, "IsActive": isActive},
    );

    if (response.data != null && response.data is List) {
      return (response.data as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    }

    return [];
  }
}
