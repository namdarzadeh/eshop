class ProductDto {
  int isactive;
  String name;
  int price;
  int instock;
  String pic;
  String details;
  String tag;

  ProductDto(
      {required this.isactive,
      required this.name,
      required this.price,
      required this.instock,
      required this.pic,
      required this.details,
      required this.tag});

  static Map<String, dynamic> toJson(final ProductDto productDto) {
    final Map<String, dynamic> map = {
      'isactive': productDto.isactive,
      'name': productDto.name,
      'price': productDto.price,
      'instock': productDto.instock,
      'pic': productDto.pic,
      'details': productDto.details,
      'tag': productDto.tag,
    };
    return map;
  }
}
