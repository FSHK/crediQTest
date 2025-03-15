import 'package:hive/hive.dart';

part 'game.g.dart';

@HiveType(typeId: 0)
class Game {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String thumbnail;

  @HiveField(3)
  String shortDescription;

  @HiveField(4)
  String gameUrl;

  @HiveField(5)
  String genre;

  @HiveField(6)
  String platform;

  @HiveField(7)
  String publisher;

  @HiveField(8)
  String developer;

  @HiveField(9)
  String releaseDate;

  @HiveField(10)
  String freeToGameProfileUrl;

  Game({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.shortDescription,
    required this.gameUrl,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.developer,
    required this.releaseDate,
    required this.freeToGameProfileUrl,
  });

  /// Convert from JSON (To process entity here)
  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      shortDescription: json['short_description'],
      gameUrl: json['game_url'],
      genre: json['genre'],
      platform: json['platform'],
      publisher: json['publisher'],
      developer: json['developer'],
      releaseDate: json['release_date'],
      freeToGameProfileUrl: json['freetogame_profile_url'],
    );
  }

  /// Convert to JSON (useful for debugging when sending API Calls)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'short_description': shortDescription,
      'game_url': gameUrl,
      'genre': genre,
      'platform': platform,
      'publisher': publisher,
      'developer': developer,
      'release_date': releaseDate,
      'freetogame_profile_url': freeToGameProfileUrl,
    };
  }
}
