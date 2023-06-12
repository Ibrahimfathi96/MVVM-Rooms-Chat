class RoomMD {
  static const String collectionName = 'Rooms Collections';
  String id;
  String title;
  String description;
  String categoryID;

  RoomMD(
      {this.id = '',
      required this.title,
      required this.description,
      required this.categoryID});

  RoomMD.fromFireStore(Map<String, dynamic> json)
      : this(
          id: json["id"],
          title: json["title"],
          description: json["description"],
          categoryID: json["categoryID"],
        );

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "categoryID": categoryID,
    };
  }
}
