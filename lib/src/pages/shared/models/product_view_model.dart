class ProductViewModel {
  int id;
  int isactive;
  String name;
  int price;
  int instock;
  String pic;
  String details;
  String tag;

  ProductViewModel(
      {required this.id,
      required this.isactive,
      required this.name,
      required this.price,
      required this.instock,
      required this.pic,
      required this.details,
      required this.tag});

  factory ProductViewModel.fromJson(final Map<String, dynamic> json) =>
      ProductViewModel(
        id: json['id'],
        isactive: json['isactive'],
        name: json['name'],
        price: json['price'],
        instock: json['instock'],
        pic: json['pic'],
        details: json['details'],
        tag: json['tag'],
      );
}
