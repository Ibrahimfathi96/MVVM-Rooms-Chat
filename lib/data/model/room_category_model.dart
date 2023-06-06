
class RoomCategoryMD {
  String roomName;
  String roomId;
  String roomImage;

  RoomCategoryMD(
      {required this.roomName, required this.roomId, required this.roomImage});

  static List<RoomCategoryMD> getRoomCategory() {
    return [
      RoomCategoryMD(
        roomName: "Music",
        roomId: "music",
        roomImage: 'music.png',
      ),
      RoomCategoryMD(
        roomName: "Sports",
        roomId: "sports",
        roomImage: 'sports.png',
      ),
      RoomCategoryMD(
        roomName: "Movies",
        roomId: "movies",
        roomImage: 'movies.png',
      ),
    ];
  }
}
