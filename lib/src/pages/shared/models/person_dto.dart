class PersonDto {
  int isadmin;
  String username;
  String password;
  String name;
  String family;
  String address;
  String favorite;

  PersonDto(
      {required this.isadmin,
      required this.username,
      required this.password,
      required this.name,
      required this.family,
      required this.address,
      required this.favorite});

  static Map<String, dynamic> toJson(final PersonDto personDto) {
    final Map<String, dynamic> map = {
      'isadmin': personDto.isadmin,
      'username': personDto.username,
      'password': personDto.password,
      'name': personDto.name,
      'family': personDto.family,
      'address': personDto.address,
      'favorite': personDto.favorite,
    };
    return map;
  }
}
