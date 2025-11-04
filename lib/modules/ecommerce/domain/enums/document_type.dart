enum DocumentType {
  nin('national_id', label: "NIN"),
  passport('passport', label: "PASSPORT"),
  driverLicense("driver_license"  , label: "DRIVER'S LICENSE");
  final String value;
  final String label;

  const DocumentType(this.value, {required this.label});
  @override
  String toString() => label;
}
