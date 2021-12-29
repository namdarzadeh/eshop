class TagViewModel {
  int id;
  String name;

  TagViewModel({required this.id, required this.name});

  factory TagViewModel.fromJson(final Map<String, dynamic> json) =>
      TagViewModel(
        id: json['id'],
        name: json['name'],
      );
}
