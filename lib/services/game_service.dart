import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import '../models/game.dart';

/// Service responsible for fetching game data from the API and caching it locally using Hive.
class GameService {
  /// Constants since this never change in this case
  static const String apiUrl = "https://cors-anywhere.herokuapp.com/https://www.freetogame.com/api/games";

  static const String boxName = "gamesBox";

  /// Fetches the list of games from the API.
  /// - If the API request is successful, stores the data in local storage.
  /// - If the request fails, retrieves cached data from local storage.
  Future<List<Game>> fetchGames() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Game> games = jsonData.map((json) => Game.fromJson(json)).toList();

        // Save to Local Storage
        var box = await Hive.openBox<Game>(boxName);
        await box.clear(); // Clearing old data
        await box.addAll(games);

        return games;
      } else {
        return [];
        throw Exception("Failed to load games");
      }
    } catch (e) {
      print("Error fetching games: $e");
      return getStoredGames(); /// Return cached data if API fails
    }
  }

  /// Returns the list of stored games from Local storage
  Future<List<Game>> getStoredGames() async {
    var box = await Hive.openBox<Game>(boxName);
    return box.values.toList();
  }
}
