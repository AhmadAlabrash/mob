class Package {
  String name;
  num revision;
  String deliveryTime;
  num regularPrice;
  num? discountPrice;
  List<ExtraField> extraFields;

  Package({
    required this.name,
    required this.revision,
    required this.deliveryTime,
    required this.regularPrice,
    required this.discountPrice,
    required this.extraFields,
  });
}

class ExtraField {
  dynamic id;
  String name;
  FieldType type;
  bool checked;
  num quantity;

  ExtraField({
    required this.id,
    required this.name,
    required this.type,
    required this.checked,
    required this.quantity,
  });
}

enum FieldType { CHECK, QUANTITY }
