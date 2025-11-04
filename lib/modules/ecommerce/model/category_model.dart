class CategoryModel {
  CategoryModel({
    required this.id,
    required this.name,
    this.description,
    this.parentId,
    this.createdAt,
    this.children = const [],
    this.count,
  });

  final int id;
  final String name;
  final String? description;
  final int? parentId;
  final DateTime? createdAt;
  final List<CategoryModel> children;
  final CatergoryCount? count;

  CategoryModel copyWith({
    int? id,
    String? name,
    String? description,
    int? parentId,
    DateTime? createdAt,
    List<CategoryModel>? children,
    CatergoryCount? count,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      parentId: parentId ?? this.parentId,
      createdAt: createdAt ?? this.createdAt,
      children: children ?? this.children,
      count: count ?? this.count,
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      parentId: json["parentId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      children:
          json["children"] == null
              ? []
              : List<CategoryModel>.from(
                json["children"]!.map((x) => CategoryModel.fromJson(x)),
              ),
      count:
          json["_count"] == null
              ? null
              : CatergoryCount.fromJson(json["_count"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "parentId": parentId,
    "createdAt": createdAt?.toIso8601String(),
    "children": children.map((x) => x.toJson()).toList(),
    "_count": count?.toJson(),
  };

  factory CategoryModel.empty() {
    return CategoryModel(id: 0, name: "");
  }

  @override
  String toString() {
    return name;
  }

  String toPrint() {
    return "$id, $name, $description, $parentId, $createdAt, $children, $count, ";
  }
}

class CatergoryCount {
  CatergoryCount({this.products = 0});

  final int products;

  CatergoryCount copyWith({int? products}) {
    return CatergoryCount(products: products ?? this.products);
  }

  factory CatergoryCount.fromJson(Map<String, dynamic> json) {
    return CatergoryCount(products: json["products"] ?? 0);
  }

  Map<String, dynamic> toJson() => {"products": products};

  @override
  String toString() {
    return "$products, ";
  }
}
