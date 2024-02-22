class BlogModel {
  String? id;
  final String title;
  final String description;
  final List<String> images; // Change this to List<String>
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BlogModel({
    this.id,
    required this.title,
    required this.description,
    required this.images,
    this.createdAt,
    this.updatedAt,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      images:
          List<String>.from(json['images']), // Convert images to List<String>
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'images': images, // List of strings will be serialized as JSON array
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
