class RoomCategory {
  static String sportsId = "sports";
  static String moviesId = "movies";
  static String musicId = "music";
  String id;
  late String name;
  late String image;

  RoomCategory(this.id, this.name, this.image);

  RoomCategory.fromId(this.id) {
    name = id;
    image = "assets/$id.jpeg";

  }

  static List<RoomCategory> getCategories() {
    return [
      RoomCategory.fromId(sportsId),
      RoomCategory.fromId(moviesId),
      RoomCategory.fromId(musicId),
    ];
  }
}