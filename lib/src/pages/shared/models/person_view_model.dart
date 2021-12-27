class PersonViewModel {
  int id;
  int isadmin;
  String username;
  String password;
  String name;
  String family;
  String address;
  String favorite;

  PersonViewModel(
      {required this.id,
      required this.isadmin,
      required this.username,
      required this.password,
      required this.name,
      required this.family,
      required this.address,
      required this.favorite});

  factory PersonViewModel.fromJson(final Map<String, dynamic> json) =>
      PersonViewModel(
        id: json['id'],
        isadmin: json['isadmin'],
        username: json['username'],
        password: json['password'],
        name: json['name'],
        family: json['family'],
        address: json['address'],
        favorite: json['favorite'],
      );
}
