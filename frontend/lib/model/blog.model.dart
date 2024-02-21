class BlogModel {
  String? id;
  String title;
  String description;
  String images;
  String owner;

  BlogModel(
      {this.id,
      required this.title,
      required this.description,
      required this.images,
      required this.owner});

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      images: json['images'],
      owner: json['owner'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "descripiton": description,
      "images": images,
      "owner": owner
    };
  }
}
