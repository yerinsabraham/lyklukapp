enum ProductType {
  none("NONE", "None"),
  physicalProduct('PHYSICAL_PRODUCT', "Physical Product"),
  digitalProduct("DIGITAL_PRODUCT", "Digital Product"),
  service("SERVICE", "Service");

  const ProductType(this.value, this.display);
  final String value;
  final String display;

  static ProductType fromString(String? value) {
    for (var type in values) {
      if (type.value == value) {
        return type;
      }
    }
    return ProductType.none;
  }
 
  static ProductType fromDisplay(String? display) {
    if(display == null) return ProductType.none;
    for (var type in values) {
      if (type.display == display) {
        return type;
      }
    }
    return ProductType.none;
  }

  @override
  String toString() => value;


 static List<ProductType>  get valuesList => [
    ProductType.physicalProduct,
    ProductType.digitalProduct,
    ProductType.service
  ];
}
