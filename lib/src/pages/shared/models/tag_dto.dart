class TagDto {
  String name;

  TagDto({required this.name});

  static Map<String, dynamic> toJson(final TagDto tagDto) {
    final Map<String, dynamic> map = {
      'name': tagDto.name,
    };
    return map;
  }
}
