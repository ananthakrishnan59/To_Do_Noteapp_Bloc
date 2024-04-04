class NoteModel {
  String? id;
  String title;
  String description;
  String? createdAt;

  NoteModel({
    this.id,
    required this.title,
    required this.description,
    this.createdAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "created_at": createdAt,
      };
}
