class MakeupModel {
  final String name;
  final String image;

  MakeupModel({required this.name, required this.image});

  factory MakeupModel.fromJson(Map<String, dynamic> json) {
    return MakeupModel(
      name: json['name'],
      image: json['image_link'],
    );
  }
}
