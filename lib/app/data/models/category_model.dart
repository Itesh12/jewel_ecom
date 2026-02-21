class CategoryModel {
  final int? categoryId;
  final String? categoryName;
  final String? description;
  final int? branchId;
  final String? branchName;
  final String? branchCode;
  final int? productCount;
  final bool? isActive;
  final String? createdDate;
  final String? modifiedDate;
  final String? image; // Added for future support or fallback

  CategoryModel({
    this.categoryId,
    this.categoryName,
    this.description,
    this.branchId,
    this.branchName,
    this.branchCode,
    this.productCount,
    this.isActive,
    this.createdDate,
    this.modifiedDate,
    this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      description: json['description'],
      branchId: json['branchId'],
      branchName: json['branchName'],
      branchCode: json['branchCode'],
      productCount: json['productCount'],
      isActive: json['isActive'],
      createdDate: json['createdDate'],
      modifiedDate: json['modifiedDate'],
      image: json['image'], // Map from JSON if exists
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['description'] = description;
    data['branchId'] = branchId;
    data['branchName'] = branchName;
    data['branchCode'] = branchCode;
    data['productCount'] = productCount;
    data['isActive'] = isActive;
    data['createdDate'] = createdDate;
    data['modifiedDate'] = modifiedDate;
    data['image'] = image;
    return data;
  }
}
