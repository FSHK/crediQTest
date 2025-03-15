import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game.dart';

final shoppingCartServiceProvider = Provider((ref) {});

/// A [StateNotifierProvider] that exposes a list of [Game] to the rest of the app.
/// It interacts with [CategoryService] to fetch, add, and update categories.
final shoppingCartProvider =
StateNotifierProvider<shoppingCartNotifier, List<Game>>((ref) {
  return shoppingCartNotifier();
});

/// A [StateNotifier] that manages the list of games.
/// This class handles operations like fetching, adding games.
class shoppingCartNotifier extends StateNotifier<List<Game>> {
  shoppingCartNotifier() : super([]);

  /// Adds a new item to the state.
  Future<void> addNewItem(Game newItem) async {
    state = [...state, newItem];
  }

  Future<bool> containsGame(Game gameToSearch) async {
    return state.contains(gameToSearch);
  }

  /// Removes an existing game item.
  Future<void> deleteExistingItem(int index) async {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
  }

  void cleanCurrentOrder() {
    state = List.empty();
  }

  Future<void> postCurrentOrder() async {
    // TODO : implement payload and api call
    cleanCurrentOrder();
  }
}
